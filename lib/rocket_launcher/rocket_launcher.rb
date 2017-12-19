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
    @usb.write(ACTIONS[:stop])
  end

  def fire(missiles = 1)
    missiles = missiles.to_i
    missiles = 4 if missiles > 4
    missiles.times do |i|
      @usb.write(ACTIONS[:fire])
      sleep 4 if i+1 != missiles
    end
  end

  [:down, :up, :left, :right].each do |dir|
    define_method dir do |time = 0.1|
      @usb.write(ACTIONS[dir])
      sleep time
      stop
    end
  end

  def park
    @usb.write(ACTIONS[:down])
    sleep 1
    @usb.write(ACTIONS[:left])
    sleep 6
    stop
  end

end
