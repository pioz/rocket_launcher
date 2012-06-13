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

  def initialize(vendor_id = 8483, product_id = 4112)
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
    missiles = 4 if missiles > 4
    missiles.to_i.times do
      @usb.write(ACTIONS[:fire])
      sleep 4
      stop
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
