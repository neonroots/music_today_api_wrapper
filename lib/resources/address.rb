module MusicTodayApiWrapper
  module Resources
    class Address
      attr_accessor :street,
                    :street_second_line,
                    :city,
                    :postal_code,
                    :country

      # rubocop:disable ParameterLists
      def initialize(street, state, city, postal_code, country = 'US',
        street_second_line = nil)
        @street = street
        @state = state
        @street_second_line = street_second_line
        @city = city
        @postal_code = postal_code
        @country = country
      end

      def self.from_hash(address_hash)
        Address.new(address_hash['street'],
                    address_hash['city'],
                    address_hash['postalCode'],
                    address_hash['country'],
                    address_hash['street2'])
      end

      def as_hash
        { street: @street,
          street2: @street_second_line,
          state: @state,
          city: @city,
          postalCode: @postal_code,
          country: @country }
      end
    end
  end
end
