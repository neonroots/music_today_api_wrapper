require 'resources/address'
require 'resources/purchase/item'

module MusicTodayApiWrapper
  module Resources
    module Checkout
      class Session
        attr_accessor :id, :address, :items

        def initialize(id, address, items = [])
          @id = id
          @address = address
          @items = items
        end

        def self.from_hash(session_hash)
          address = Address.from_hash(session_hash)
          session = Session.new(session_hash['sessionId'], address)
          session_hash['items'].each do |item|
            session.items << Resources::Purchase::Item.from_hash(item)
          end
          session
        end
      end
    end
  end
end
