Integer.class_eval do
  # 3.tries :on => NoMethodError do
  #   # ... my risky code ...
  # end
  def tries(options={}, &block)
    attempts          = self
    exception_classes = [*options[:on] || StandardError]
 
    begin
      return yield
    rescue *exception_classes
      retry if (attempts -= 1) > 0
    end
 
    yield
  end
end
