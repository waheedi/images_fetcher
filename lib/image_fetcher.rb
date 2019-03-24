module ImageFetcher
  module Engine
    class << self

      # Starting the read/parse and fetch process
      def go
        create_base_storage
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

      def create_base_storage
        base_path = ImageFetcher::Options.options.storage
        Dir.mkdir(base_path) unless File.exists?(base_path)
      end

    end # class self
  end # module Engine
end # module ImageFetcher
