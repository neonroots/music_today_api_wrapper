module MusicTodayApiWrapper
  class ::Hash
    def compact
      self.select { |_, value| !value.nil? }
    end
  end
end
