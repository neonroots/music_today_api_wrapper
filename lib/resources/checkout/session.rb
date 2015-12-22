require 'resources/address'

module MusicTodayApiWrapper
  module Resources
    module Checkout
      class Session
        attr_accessor :id, :address, :items

        def initialize(id, address = Address.new, items= [])
          @id = id
          @address = address
          @items = items
        end

        def from_hash(session_hash)
          session = Session.new(session_hash['sessionId'])
          session.address = Address.from_hash(session_hash['addresses'][0])
          session_hash['items'].each do |item|
            session.items << Item.from_hash(item)
          end
          session
        end
      end
    end
  end
end
