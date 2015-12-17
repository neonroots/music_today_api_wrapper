module MusicTodayApiWrapper
  module Resources
    class Address
      attr_accessor :street,
                    :street_second_line,
                    :city,
                    :postal_code,
                    :country, :items

      # rubocop:disable ParameterLists
      def initialize(street, city, postal_code, country = 'US',
        street_second_line = nil, items = [])
        @street = street
        @street_second_line = street_second_line
        @city = city
        @postal_code = postal_code
        @country = country
        @items = items
      end

      def self.from_hash(address_hash)
        Address.new(address_hash['street'],
                    address_hash['city'],
                    address_hash['postal_code'],
                    address_hash['country'],
                    address_hash['street2'])
      end
    end
  end
end
