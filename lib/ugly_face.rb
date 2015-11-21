require "ugly_face/version"
require "ugly_face/formatter/html"

module UglyFace
  @index = 0
  @scenario_msgs = Hash.new
  @msg_storage = Array.new
  @cli_output=''
  @html_output=''

  def self.add_msg(key='', msg='')
    @scenario_msgs[:"#{key}"] = msg
  end

  def self.process_scenario
    raw_output=''
    @scenario_msgs.each { |key, value| raw_output << "+#{key}:+ #{value}+" }
    raw_output= raw_output.gsub("+ ++","++")
    @cli_output= raw_output.gsub("+","\n")
    @html_output= raw_output.gsub("+","<br />")
    @msg_storage.push(@html_output)
    $stdout.puts @cli_output unless ENV['DEBUG']== 'FALSE'
  end

  def self.reset
    @scenario_msgs= {}
    @cli_output= ''
    @html_output= ''
  end

  def self.pop_scenario
    @msg_storage.at(@index)
    @index+=1
  end

  def self.formatted_cli
    @cli_output
  end

  def self.formatted_html
    @html_output
  end


end
