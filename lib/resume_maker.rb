require_relative 'user_io_handler'
require_relative 'plugin_handler'
require_relative 'user'

# Main class that controls the program
class ResumeMaker
  attr_accessor :io_handler, :plugin_handler
  def initialize
    @io_handler = UserIOHandler.new
    @plugin_handler = PluginHandler.new
    @user = User.new('not specified', 'not specified', 'not specified')
  end

  def start
    @plugin_handler.load_plugins('lib/plugins')
    loop do
      @io_handler.clear_screen
      choice = display_main_menu_and_get_choice
      case choice
      when 1
        @user.name = @io_handler.ask_user_for('Name')
        @user.age = @io_handler.ask_user_for('Age')
        @user.place = @io_handler.ask_user_for('Place')
      when 2
        format_choice = display_format_choice_menu_and_get_choice
        @plugin_handler.current_format = format_choice
      when 3
        export
      when 4
        break
      end
    end
  end

  def display_main_menu_and_get_choice
    @io_handler.display_menu_and_get_choice(
      %(Enter-details Choose-Format Export Quit).split,
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
    file_name = @io_handler.ask_user_for('file name')
    @plugin_handler.export(@user, file_name)
  end
end
