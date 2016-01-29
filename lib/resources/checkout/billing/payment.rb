require 'resources/hash'
require 'credit_card_validator'

module MusicTodayApiWrapper
  module Resources
    module Checkout
      module Billing
        class Payment
          attr_accessor :card_number,
                        :card_type,
                        :expiration_year,
                        :expiration_month,
                        :name,
                        :amount

          def initialize(card_number, name, amount, expiration_year,
            expiration_month)
            @card_number = card_number
            @expiration_year = expiration_year.to_i
            @expiration_month = expiration_month.to_i
            @name = name
            @amount = amount.to_f
            credit_card_type
          end

          def as_hash
            { type: @card_type,
              accountNumber: @card_number,
              expYear: @expiration_year,
              expMonth: @expiration_month,
              nameOnCard: @name,
              amount: @amount }.compact
          end

          private

          def credit_card_type
            @card_type =
              case CreditCardValidator::Validator.card_type(@card_number)
              when 'visa'
                'VISA'
              when 'master_card'
                'MC'
              when 'amex'
                'AMEX'
              when 'discover'
                'DISCOVER'
              end
          end
        end
      end
    end
  end
end
