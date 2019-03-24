require 'open-uri'

module ImageFetcher
  module Parser
    class RawFile
      #this will read plain files ("new line seperated") and send each line to be fetched using our fetchers

      attr_accessor :path

      def initialize
        self.path = ImageFetcher::Options.options.source
      end

      def read
        # Read a raw file (new line seperated) and fetch each image-uri inside it
        open(self.path) do |file|
          file.each_line do |uri|
            ImageFetcher::Fetcher::Http.new(uri)
          end
        end
      end

    end
  end
end
