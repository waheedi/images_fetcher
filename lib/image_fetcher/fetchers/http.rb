require 'net/http'

module ImageFetcher
  module Fetcher
    class Http

      attr_accessor :resource_uri, :resource_current_path

      def initialize(uri)
        self.resource_uri = uri
        self.fetch_resource
      end


      # Fetchs a resouce by creating an HTTP request and reading response and writeing it in chunks
      def fetch_resource
        verbose = ImageFetcher::Options.options.verbose
        begin
          uri = URI(self.resource_uri)
          raise URI::InvalidURIError, "No scheme/protocol" unless uri.scheme
          use_ssl ||= uri.scheme == "https"
          write_on_path = Http.get_filename_path(uri)
        rescue URI::InvalidURIError => error
          puts "#{self.resource_uri} is not valid URI. #{error.message}"
          return false
        end

        puts "Downloading from #{self.resource_uri}" if verbose

        fetcher = Thread.new do
          begin
            Net::HTTP.start(uri.host, uri.port, :use_ssl => use_ssl) do |http|
              request = Net::HTTP::Get.new(uri)
              http.request(request) do |response|
                open(write_on_path , 'w') do |io|
                  response.read_body do |chunk|
                    print "#" if verbose
                    io.write chunk
                  end
                end
              end
            end
          rescue SocketError
            puts "No internet connection or URI is not reachable at the moment"
          end
        end
        fetcher.join
        self.resource_current_path = write_on_path
        puts "\nResource is ready at #{write_on_path}" if verbose
        return true
      end # method fetch_resource


      # populate filename from the original filename and prepend it with epoch time, and the base sotrage location
      def self.get_filename_path(uri)
        storage_base = ImageFetcher::Options.options.storage
        uniq_filename = "#{Time.now.to_i}_#{File.basename(uri.path)}"
        return storage_base + uniq_filename
      end

    end # class Http
  end # module Fetchers
end # module ImageFetcher
