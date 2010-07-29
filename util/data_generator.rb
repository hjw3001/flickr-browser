require 'xml-object'
require 'flickrx'

class DataGenerator
  attr_reader :reflector
  
  def initialize
    @reflector = Flickrx::Reflection.new
    # puts reflector.getMethods
    rsp = XMLObject.new(@reflector.getMethods)
    puts rsp[:methods].each { |m| generate_xml(m) }
    # xml.methods.map { |m| puts m }
  end
  
  def generate_xml(method_name)
    puts method_name
    
    data = @reflector.getMethodInfo(method_name)
    
    output_file = "../data/#{method_name}.xml"
    File.open(output_file, 'wb') do |dest|
      dest.write data
    end
  end
end

DataGenerator.new