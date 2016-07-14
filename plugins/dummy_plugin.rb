require_relative 'resume_maker_plugin'

class DummyPlugin < ResumeMakerPlugin
  @output_format = 'Dummy Format'
  class << self
    attr_reader :output_format
  end

  def self.export(_user_details, _file_name)
    'success'
  end
end