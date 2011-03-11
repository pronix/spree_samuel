String.class_eval do
  def escape_quotes
    self.gsub(/("|')/, '\\\\\1')
  end
  
  def add_slashes
    self.gsub(/\//, '\\\\\'')
  end

  def strip_slashes
    self.gsub(/\\/, '')
  end
  
  def maxlength(count, suffix="... ")
    self.length > count ? self.first(count) + suffix : self
  end
  
  def initial_caps
    self.gsub(/\b\w/) { $&.upcase }
  end

  def email_valid?
		self.size < 100 && self =~ /(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i && self.count('@') == 1
	end
	
	def to_quoted_printable(*args)
    [self].pack("M").gsub(/\n/, "\r\n")
  end
  
  def from_quoted_printable
    self.gsub(/\r\n/, "\n").unpack("M").first
  end
end