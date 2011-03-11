module TimeUtils
  def db
    self.strftime("%Y-%m-%d %H:%M:%S %Z")
  end
  
  def month_year
    "#{self.strftime('%b')} #{self.year}"
  end
    
  def month_day
    "#{self.strftime('%b')} #{self.day}"
  end
  
  def hr_min
    self.strftime("%I:%M%p").sub(/^0/,'')
  end
  
  def short_date
    self.strftime(self.year == Time.now.year ? "%a, %b %d" : "%a, %b %d %y")
  end
  
  def short_date_and_time
    "#{self.short_date} #{self.hr_min}"
  end
  
  def w3c
    self.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end

  def local_to_utc(offset)
    Time.at(self.utc.to_i + (offset.to_f * 3600).to_i)
  end

  def utc_to_local(offset)
    Time.at(self.utc.to_i - (offset.to_f * 3600).to_i)
  end
end

Time.class_eval do
  include TimeUtils
  
  def to_datetime
    DateTime.civil(year, mon, day, hour, min, sec)
  end
end

DateTime.class_eval do
  include TimeUtils
  
  def db_with_slashes
    self.strftime("%Y/%m/%d %I:%M:%S%p")
  end
  
  def to_time
    Time.mktime(year, mon, day, hour, min, sec)
  end
end if Object.const_defined? :DateTime

Date.class_eval do
  def to_i
    self.strftime("%Y%m%d").to_i
  end
  
  def db
    self.strftime("%Y-%m-%d")
  end

  def slashed
    self.strftime("%m/%d/%Y")
  end
  
  def short_date
    self.strftime(self.year == Time.now.year ? "%a, %b %d" : "%a, %b %d %Y")
  end
  
  def month_day(separator="/")
    d = [self.mon, self.mday]
    d << self.year unless self.year == Time.now.year
    d.join(separator)
  end
end if Object.const_defined? :Date