module FCG
  module Client
    module Venue
      ATTRIBUTES = [:active, :address, :city, :region, :country, :created_at, :lat, :lng, :name, :state, :time_zone, :updated_at, :user_id, :zipcode].freeze

      module ClassMethods
        def autocomplete(term, *args)
          opts = args.extract_options!
          params = {
            :term => term,
            :limit => 10,
            :skip => 0
          }.merge(opts)
          request = send_to_server(:method => :get, :path => "#{service_url}/autocomplete", :params => params)
          handle_service_response request.handled_response
        end
      end

      module InstanceMethods
        def full_address
          @full_address = "#{self.address}, #{self.city}, #{self.state}, #{self.zipcode}"
          @full_address << ", #{self.country}" unless in_us?
          @full_address
        end

        def to_param
          "#{id}-#{[name, address, city, state].join(' ').gsub(/[^a-z0-9]+/i, '_')}"
        end

        def not_in_us?
          !self.country == "US"
        end

        def in_us?
          self.country == "US"
        end
      end

      def self.included(receiver)
        receiver.extend         ClassMethods
        receiver.send :include, FCG::Client::Persistence
        receiver.send :include, InstanceMethods
      end
    end
  end
end