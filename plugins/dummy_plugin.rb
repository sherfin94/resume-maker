require_relative 'resume_maker_plugin'

class DummyPlugin < ResumeMakerPlugin
  @output_format = 'Dummy'
  class << self
    attr_reader :output_format
  end

  def self.export(user_details, file_name)
    'success'
  end
end
