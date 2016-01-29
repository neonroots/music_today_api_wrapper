module MusicTodayApiWrapper
  module Resources
    module Purchase
      class Invoice
        attr_accessor :id, :sub_total, :shipping, :taxes, :total

        def initialize(id, sub_total, shipping, taxes)
          @id = id
          @sub_total = sub_total.to_f
          @shipping = shipping.to_f
          @taxes = taxes.to_f
          @total = (@sub_total + @shipping + @taxes).round(2)
        end

        def self.from_hash(hash)
          totals = hash['billing']['totals']
          Invoice.new(hash['orderNumber'],
                      totals['subtotal'],
                      totals['shipping'],
                      totals['totalTax'])
        end
      end
    end
  end
end
