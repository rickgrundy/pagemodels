module PageModels  
  class Base
    # Capybara's select method is far more likely than Kernel#select.
    def select(*args)
      config.driver.select(*args)
    end
  end
end