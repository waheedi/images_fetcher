module ImageFetcher
  module Engine
    class << self

      def go
        # Let's roll. starting the read/parse and fetch process
        raw_file_parser = ImageFetcher::Parser::RawFile.new
        raw_file_parser.read
      end

      # Just a place holder incase we decided to use more stuff :)
      def teardown
        puts "\n are you sure you want to end fetcher Y/n?"
        while cmd = gets
          exit if cmd.downcase == "y" || cmd.downcase == "\n"
        end
      end

    end # class self
  end # module Engine
end # module ImageFetcher
