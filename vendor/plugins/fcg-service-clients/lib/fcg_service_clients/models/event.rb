module FCG
  module Client
    module Event
      ATTRIBUTES = [:active, :comments_allowed, :created_at, :date, :description, :dj, :end_time, :end_time_utc, :flyer_album_id, :host, :length_in_hours, 
        :music, :party_id, :photo_album_id, :posted_to_twitter_at, :recur, :start_time, :start_time_utc, :title, :updated_at, :user_id, :venue, :venue_id].freeze

      module ClassMethods
        def upcoming_the_next_7_days
          now = 6.hours.ago(Time.now.utc)
          date_range = now.beginning_of_day..7.days.since(now).end_of_day
          search(:conditions => {:active => true, :start_date => date_range.first.to_i, :end_date => date_range.last.to_i})
        end
        
        def find_by_region(region, *args)
          opts = args.extract_options!
          params = {
            :state => "past", # past, between, or future
            :time => Time.now.utc,
            :limit => 10,
            :active => true,
            :skip => 0
          }.merge(opts)
          request = send_to_server(:method => :get, :path => "#{service_url}/region/#{region}", :params => params)
          handle_service_response request.handled_response
        end
      end
      
      module InstanceMethods
        def cover_image
          ::Image.find(photos_sorted.first) unless photos.empty?
        end

        def venue_name
          venue[:name]
        end
        
        def party
          @party = ::Party.find attributes.party_id
        end

        def full_address
          "#{venue.address}, #{venue.city}, #{venue.state}, #{venue.zipcode}"
        end
        
        def time_zone
          venue[:time_zone]
        end

        def title_and_venue_name
          "#{title} at #{venue_name}"
        end

        def album_title(album_type=nil)
          txt = "#{date.to_s(:slash)}: #{title} at #{venue_name}"
          album_type = self.image_method(album_type.to_sym) rescue nil
          txt << "(" + album_type["title"] + ")" unless album_type.nil?
          txt
        end

        # def set_to_param
        #   write_attribute :to_param, %Q{#{self.id}-#{[self.title, self.venue.name, self.venue.city, self.venue.state].join(' ').gsub(/[^a-z0-9]+/i, '_')}}
        # end

        def past?
          self.end_time_utc < Time.now.utc
        end

        def uploadable_by_user?(*args)
          self.party.uploadable_by_user?(*args)
        end
        
        def date
          Date.parse(self.raw_attributes[:date]) rescue nil
        end
        
        def flyer_album
          @flyer_album ||= ::Album.find flyer_album_id unless flyer_album_id.nil?
        end
        
        def photo_album
          @photo_album ||= ::Album.find photo_album_id unless photo_album_id.nil?
        end
        
        def photo_album_title
          txt = date.short_date + ": #{title_and_venue_name}"
          txt << " (#{photo_album.title})" if !photo_album.nil? and photo_album.respond_to? :title
          txt
        end
        
        def flyer_album_title
          txt = date.short_date + ": #{title_and_venue_name}"
          txt << " (#{flyer_album.title})" if !flyer_album.nil? and flyer_album.respond_to? :title
          txt
        end
        
        def end_time_utc
          Time.parse(self.raw_attributes[:end_time_utc]) rescue nil
        end

        def start_time_utc
          Time.parse(self.raw_attributes[:start_time_utc]) rescue nil
        end
      end

      def self.included(receiver)
        receiver.extend         ClassMethods
        receiver.send :include, FCG::Client::Persistence
        receiver.send :include, InstanceMethods
        receiver.validates_presence_of :user_id, :party_id, :venue, :date
        receiver.validates_format_of :start_time, :with => /^(0?[1-9]|1[0-2]):(00|15|30|45)(a|p)m$/i
        receiver.validates_format_of :end_time, :with => /^(0?[1-9]|1[0-2]):(00|15|30|45)(a|p)m$/i
      end
    end
  end
end