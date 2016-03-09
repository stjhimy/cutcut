module CutCut
  # Helpers
  class Helpers
    def self.longest_common_substring(*strings)
      shortest = strings.min_by(&:length)
      maxlen = shortest.length
      maxlen.downto(0) do |len|
        0.upto(maxlen - len) do |start|
          substr = shortest[start, len]
          return substr if strings.all? { |str| str.include? substr }
        end
      end
    end
  end
end
