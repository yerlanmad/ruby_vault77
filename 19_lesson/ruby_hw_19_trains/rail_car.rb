class RailCar
  include Manufacturer
  attr_reader :car_type

  def initialize(**opts)
    @car_type = opts[:type] || default_type
    @manufacturer = opts[:manufacturer] || default_manufacturer
    post_initialize(opts)
  end

  protected

  # subclasses may override
  def post_initialize(opts); end

  def default_type
    'Flatcar'
  end
end
