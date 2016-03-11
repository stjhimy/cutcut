module CutCut
  # Helpers
  class Helpers
    def self.longest_common_substring(*strings)
      short = strings.min_by(&:length)
      max = short.length
      max.downto(0) do |len|
        0.upto(max - len) do |start|
          substr = short[start, len]
          return substr if strings.all? { |str| str.include? substr }
        end
      end
    end
  end
end
