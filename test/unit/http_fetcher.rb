require 'image_fetcher'
require 'image_fetcher/options'
require 'image_fetcher/fetchers/http'
require 'fileutils'

samples_path = "#{Dir.pwd}/test/samples/"
argv = ["-s", "fixtures/source_images.txt", "-p", samples_path]

https_uri = "https://images.pexels.com/photos/2034378/pexels-photo-2034378.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
h"
http_uri = "http://image-net.org/logo.png"

options = ImageFetcher::Options.parse(argv)

describe  ImageFetcher::Fetcher::Http do

  before(:all) do
    FileUtils.rm_rf(samples_path)
    Dir.mkdir(samples_path)
    puts "#{samples_path} dir is created"
  end

  after(:all) do
    FileUtils.rm_rf(samples_path)
    puts "#{samples_path} dir is deleted"
  end

  context "When provided with valid https uri" do
    it "downloads a resource file to the specified location" do
      http_fetcher = ImageFetcher::Fetcher::Http.new(https_uri)
      expect(File).to exist(http_fetcher.resource_current_path)
    end
  end

  context "When provided with valid http uri" do
    it "downloads a resource file to the specified location" do
      http_fetcher = ImageFetcher::Fetcher::Http.new(http_uri)
      expect(File).to exist(http_fetcher.resource_current_path)
    end
  end

  context "When provided with a uri without a scheme/protcol" do
    it "handles URI::InvalidURIError gracefully" do
      expect(ImageFetcher::Fetcher::Http.new("")).to be_a ImageFetcher::Fetcher::Http
    end
  end

  context "When provided with an invalid uri" do
    it "handles URI::InvalidURIError gracefully" do
      expect(ImageFetcher::Fetcher::Http.new("\n")).to be_a ImageFetcher::Fetcher::Http
    end
  end

end
