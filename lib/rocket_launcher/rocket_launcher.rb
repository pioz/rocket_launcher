class RocketLauncher

  ACTIONS = {
    :down  => 0x01,
    :up    => 0x02,
    :left  => 0x04,
    :right => 0x08,
    :fire  => 0x10,
    :stop  => 0x20,
    :park  => 0x00
  }

  def initialize(vendor_id = 0x2123, product_id = 0x1010)
    @usb = USB.new
    @usb.open(vendor_id, product_id)
  end

  def close
    @usb.close
  end

  def stop
    @usb.write(ACTIONS[:stop], false)
  end

  def fire
    light(true)
    @usb.write(ACTIONS[:fire], false)
    sleep 3.5
    @usb.write(ACTIONS[:stop], false)
    light(false)
  end

  [:down, :up, :left, :right].each do |dir|
    define_method dir do |time = 0.1|
      @usb.write(ACTIONS[dir], false)
      sleep time
      stop
    end
  end

  def park
    @usb.write(ACTIONS[:down], false)
    sleep 1
    @usb.write(ACTIONS[:left], false)
    sleep 6
    stop
  end

  def light(status)
    @usb.write(status ? 0x01 : 0x00, true)
  end

end
