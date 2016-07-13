require 'user_io_handler'
require 'plugin_handler'

# Main class that controls the program
class ResumeMaker
  attr_accessor :io_handler, :plugin_handler
  def initialize
    @io_handler = UserIOHandler.new
    @plugin_handler = PluginHandler.new

    # @plugin_handler.load_plugins
  end

  def start
    loop do
      clear_screen
      # choice = display_main_menu_and_get_choice
    end
  end

  def display_main_menu_and_get_choice
    @io_handler.display_menu_and_get_choice(
      %(Choose-Format Export Quit),
      'option'
    )
  end

  def load_plugins
    @plugin_handler.load_plugins
  end

  def display_format_choice_menu_and_get_choice
    @io_handler.display_menu_and_get_choice(
      @plugin_handler.list_plugins,
      'format'
    )
  end

  def export
    name = @io_handler.ask_user_for('Name')
    age = @io_handler.ask_user_for('Age')
    place = @io_handler.ask_user_for('Place')
    file_name = @io_handler.ask_user_for('File name')
    plugin_handler.export([name, age, place], file_name)
  end
end
