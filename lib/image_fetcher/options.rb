require 'optparse'
require 'optparse/time'
require 'optparse/uri'

module ImageFetcher

  module Options

    CODES = %w[ISO-8859-1 utf8]
    FORMATS = %w[plain json html xml yml]

    class ScriptOptions
      attr_accessor  :source, :storage, :format, :delay, :time, :verbose

      def initialize
        self.source = nil
        self.format = 'plain'
        self.storage =  "#{Dir.home}/imageFetcher/"
        self.verbose = false
      end

      def define_options(parser)
        parser.banner = 'Usage: image_fetcher.rb [options]'
        parser.separator ''
        parser.separator 'ImageFetcher options:'

        # ImageFetcher options
        source_location_option(parser)
        source_format_option(parser)
        storage_option(parser)
        delay_execution_option(parser)
        execute_at_time_option(parser)
        boolean_verbose_option(parser)

        parser.separator ''
        parser.separator 'Common options:'

        # print help on tail
        parser.on_tail('-h', '--help', 'Show this message') do
          puts parser
          exit
        end

        # print ImageFetcher version.
        parser.on_tail('--version', 'Show version') do
          puts ImageFetcher::VERSION
          exit
        end
      end

      # Get source file location/URI as string, type will decide which method will be used to parse/read the file
      def source_location_option(parser)
        parser.on('-s', '--source FILE', String,  'Source file/URI to be used as source for image fetcher') do |uri|
          self.source = uri
        end
      end

      # Get the source file format
      def source_format_option(parser)
        format_list = FORMATS.join(', ')
        parser.on('-f', '--format FORMAT',  FORMATS, 'Source file format type (default: "plain")', "(#{format_list})") do |format|
          self.format = format
        end
      end

      # Get the storage option for saving fetched images, currently
      # will be default to local drive, later can be remote
      def storage_option(parser)
          parser.on('-p', '--storage DESTINATION', String, 'Storage destination for ImageFetcher (default: "~/ImageFetcher/images")') do |storage|
          self.storage = storage
        end
      end

      # Cast 'delay' argument to a Float.
      def delay_execution_option(parser)
        parser.on('--delay N', Float, 'Delay N seconds before executing') do |n|
          self.delay = n
        end
      end


      # Cast 'time' argument to a Time object.
      def execute_at_time_option(parser)
        parser.on('-t', '--time [TIME]', Time, 'Begin execution at given time') do |time|
          self.time = time
        end
      end

      # Boolean switch for verbosity.
      def boolean_verbose_option(parser)
        parser.on('-v', '--verbose', 'Run verbosely') do |v|
          self.verbose = v
        end
      end
    end

    #
    # Return a structure describing the options.
    #
    class << self
      def parse(args)
        # The options specified on the command line will be collected in
        # *options*.
        @options = ScriptOptions.new
        @args = OptionParser.new do |parser|
          @options.define_options(parser)
          parser.parse!(args)
        end
        @options
      end
      attr_reader :options
    end #class ScriptOption
  end #module Options
end  # module ImageFetcher

