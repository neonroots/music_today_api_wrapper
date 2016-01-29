require 'resources/hash'

module MusicTodayApiWrapper
  module Resources
    module Checkout
      module Billing
        class Customer
          attr_accessor :name,
                        :lastname,
                        :street,
                        :city,
                        :state,
                        :zip_code,
                        :phone,
                        :email,
                        :country

          # rubocop:disable ParameterLists
          def initialize(name = '', lastname = '', street = '', city = '',
            state = '', zip_code = '', phone = '', email = '', country = 'US')
            @name = name
            @lastname = lastname
            @street = street
            @city = city
            @state = state
            @zip_code = zip_code
            @phone = phone
            @email = email
            @country = country
          end

          def as_hash
            { firstName: @name,
              lastName: @lastname,
              street: @street,
              street2: '',
              city: @city,
              state: @state,
              postalCode: @zip_code,
              country: @country,
              phone: @phone,
              email: @email }.compact
          end
        end
      end
    end
  end
end
