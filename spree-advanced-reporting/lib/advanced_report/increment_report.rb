class AdvancedReport::IncrementReport < AdvancedReport
  INCREMENTS = [:daily, :weekly, :monthly, :quarterly, :yearly]
  attr_accessor :increments, :dates, :total, :all_data

  def initialize(params)
    super(params)
  
    self.increments = INCREMENTS 
    self.ruportdata = INCREMENTS.inject({}) { |h, inc| h[inc] = Table(%w[key display value]); h }
    self.data = INCREMENTS.inject({}) { |h, inc| h[inc] = {}; h }

    self.dates = {
      :daily => {
        :date_bucket => "%F",
        :date_display => "%m-%d-%Y",
        :header_display => 'Daily',
      },
      :weekly => {
        :header_display => 'Weekly'
      },
      :monthly => {
        :date_bucket => "%Y-%m",
        :date_display => "%B %Y",
        :header_display => 'Monthly',
      },
      :quarterly => {
        :header_display => 'Quarterly'
      },
      :yearly => {
        :date_bucket => "%Y",
        :date_display => "%Y",
        :header_display => 'Yearly',
      }
    }
  end

  def generate_ruport_data
    self.all_data = Table(%w[increment key display value]) 
    INCREMENTS.each do |inc|
      data[inc].each { |k,v| ruportdata[inc] << { "key" => k, "display" => v[:display], "value" => v[:value] } }
      ruportdata[inc].data.each do |p|
        self.all_data << { "increment" => inc.to_s.capitalize, "key" => p.data["key"], "display" => p.data["display"], "value" => p.data["value"] }
      end
      ruportdata[inc].sort_rows_by!(["key"])
      ruportdata[inc].remove_column("key")
      ruportdata[inc].rename_column("display", dates[inc][:header_display])
      ruportdata[inc].rename_column("value", self.class.name.split('::').last)
    end
    self.all_data.sort_rows_by!(["key"])
    self.all_data.remove_column("key")
    self.all_data = Grouping(self.all_data, :by => "increment") 
  end
  
  def get_bucket(type, completed_at)
    if type == :weekly
      return completed_at.beginning_of_week.strftime("%Y-%m-%d")
    elsif type == :quarterly
      return completed_at.beginning_of_quarter.strftime("%Y-%m")
    end
    completed_at.strftime(dates[type][:date_bucket])
  end

  def get_display(type, completed_at)
    if type == :weekly
      #funny business
      #next_week = completed_at + 7
      return completed_at.beginning_of_week.strftime("%m-%d-%Y") # + ' - ' + next_week.beginning_of_week.strftime("%m-%d-%Y")
    elsif type == :quarterly
      return completed_at.strftime("%Y") + ' Q' + (completed_at.beginning_of_quarter.strftime("%m").to_i/3 + 1).to_s
    end
    completed_at.strftime(dates[type][:date_display])
  end

  def format_total
    self.total 
  end
end
