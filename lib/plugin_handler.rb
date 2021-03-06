require_relative 'plugins/resume_maker_plugin'
# Class for handling format plugins
class PluginHandler
  attr_accessor :current_format
  def initialize
    @current_format = 1
    @plugins = []
  end

  def export(user, file_name)
    @plugins[@current_format - 1].export(user, file_name)
  end

  def load_classes_from_folder(folder_name)
    files_in_folder = Dir.entries(folder_name).select do |entry|
      entry =~ /.*\.rb/
    end
    files_in_folder.each do |file_name|
      require_relative "../#{folder_name}/#{file_name}"
    end
  end

  def load_plugins(folder_name)
    existing_classes = ObjectSpace.each_object(Class).to_a
    load_classes_from_folder(
      folder_name
    )
    new_classes = ObjectSpace.each_object(Class).to_a - existing_classes

    new_classes.each do |the_class|
      @plugins << the_class if the_class < ResumeMakerPlugin
    end
  end

  def list_plugins
    @plugins.map(&:output_format)
  end
end
