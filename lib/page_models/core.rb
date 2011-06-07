module PageModels
  def self.configure
    config = PageModels::Configuration.instance
    yield(config)
    config.integrate!
  end
  
  def self.create(page, args)
    args = args.scan(/"([^"]+)"/).map(&:first)
    page_model_class_name = page.gsub(/(?:^|[^\w])([a-z])/) { $1.upcase }
    Kernel.const_get(page_model_class_name).new(*args)
  end
end