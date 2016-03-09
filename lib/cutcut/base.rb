module CutCut
  # Base
  class Base
    attr_reader :input, :output

    private

    def execute_ffmpeg_command(options = {})
      input_file = options.delete(:input_file)
      output_file = options.delete(:output_file)
      raw_options = options.delete(:raw_options)
      system("ffmpeg -i #{input_file} #{raw_options} #{output_file} -y > /dev/null 2>&1")
    end
  end
end
