module CutCut
  # Base
  class Base
    attr_reader :input, :output

    private

    def execute_ffmpeg_command(options = {})
      input_file = options.delete(:input_file)
      output_file = options.delete(:output_file)
      input_raw_options = options[:raw_options].try(:[], :input)
      output_raw_options = options[:raw_options].try(:[], :output)

      system("ffmpeg #{input_raw_options} -i #{input_file} #{output_raw_options} #{output_file} -y > /dev/null 2>&1")
    end
  end
end
