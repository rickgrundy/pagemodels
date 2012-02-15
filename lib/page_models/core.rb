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
  rescue NameError => e
    if e.instance_of?(NameError) # Could be a NoMethodError
      raise MissingPageModelError.new(page_model_class_name)
    else
      raise e
    end
  end
end