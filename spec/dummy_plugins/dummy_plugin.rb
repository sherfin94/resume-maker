require_relative '../../lib/plugins/resume_maker_plugin'

class DummyPlugin < ResumeMakerPlugin
  @output_format = 'Dummy Format'
  class << self
    attr_reader :output_format
  end

  def self.export(_user, _file_name)
    'success'
  end
end
