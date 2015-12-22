module MusicTodayApiWrapper
  class ::String
    def to_underscore!
      gsub!(/(.)([A-Z])/, '\1_\2')
      downcase!
    end

    def to_underscore
      dup.tap(&:to_underscore!)
    end
  end
end
