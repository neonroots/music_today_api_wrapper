module MusicTodayApiWrapper
  # rubocop:disable ClassAndModuleChildren
  class ::Hash
    def compact
      select { |_, value| !value.nil? }
    end
  end
end
