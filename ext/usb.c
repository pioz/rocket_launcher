#include <ruby.h>
#include <libusb-1.0/libusb.h>

unsigned char DATA[8] = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

typedef struct
{
  libusb_context *ctx;
  libusb_device_handle *handler;
} USB;

VALUE error;

void
usb_free (USB *usb)
{
  if (usb->handler)
    libusb_close (usb->handler);
  if (usb->ctx)
    libusb_exit (usb->ctx);
  free (usb);
}

VALUE
usb_alloc (VALUE class)
{
  USB *usb = (USB *) malloc (sizeof (USB));
  usb->ctx = NULL;
  usb->handler = NULL;
  int r = libusb_init (&usb->ctx);
  if (r < 0)
    rb_raise (error, "Failed to init libusb");
  return Data_Wrap_Struct (class, 0, usb_free, usb);
}

VALUE
open_device (VALUE self, VALUE vid, VALUE pid)
{
  USB *usb;
  Data_Get_Struct (self, USB, usb);
  usb->handler = libusb_open_device_with_vid_pid (usb->ctx, NUM2ULONG (vid), NUM2ULONG (pid));
  if (!usb->handler)
    rb_raise (error, "Can't open device");
  return Qnil;
}

VALUE
close_device (VALUE self)
{
  USB *usb;
  Data_Get_Struct (self, USB, usb);
  if (usb->handler)
    libusb_close (usb->handler);
  usb->handler = NULL;
  return Qnil;
}

VALUE
write (VALUE self, VALUE cmd)
{
  USB *usb;
  Data_Get_Struct (self, USB, usb);
  DATA[1] = NUM2CHR (cmd);
  if (libusb_control_transfer (usb->handler, 0x21, 0x9, 0, 0, DATA, 8, 0) != 8)
    rb_raise (error, "Write error");
  return Qnil;
}

void
Init_usb ()
{
  error = rb_define_class ("USBError", rb_eStandardError);
  VALUE usb = rb_define_class ("USB", rb_cObject);
  rb_define_alloc_func (usb, usb_alloc);
  rb_define_method (usb, "open", open_device, 2);
  rb_define_method (usb, "close", close_device, 0);
  rb_define_method (usb, "write", write, 1);
}