require 'sinatra'
require 'erb'
require 'cgi'
require 'xml-object'

module FlickrBrowser
  class Browser
    attr_reader :xml_files
    
    def initialize
      load_data
    end
    
    def load_data
      @xml_files = Array.new
      directory = File.expand_path(File.dirname(__FILE__))
      current_directory = Dir.getwd
      Dir.chdir("#{directory}/data")
      Dir["*.xml"].each { |xml_file|
        @xml_files << XMLObject.new(File.open(xml_file))
      }
      Dir.chdir(current_directory)
    end
  end
end

get '/' do
  @browser = FlickrBrowser::Browser.new
  erb :index
end

get '/browse/:name' do
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params[:name] is 'foo' or 'bar'
  @method_name = params[:name]
  @browser = FlickrBrowser::Browser.new
  @browser.xml_files.each { |xml|
    if (xml[:method].name == @method_name)
      @xml_data = xml
    end
  }
  erb :browse
end

post '/expore' do

end
