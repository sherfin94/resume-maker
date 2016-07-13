# Handles User Input Output
class UserIOHandler
  def show_message(message)
    puts message
  end

  def display_menu_and_get_choice(list, required_choice_criteria)
    puts "Choose your #{required_choice_criteria}\n"
    list.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end

    print 'your option : '
    Integer(gets)
  end

  def ask_user_for(parameter)
    print "Enter #{parameter} : "
    gets
  end

  def clear_screen
    # system 'clear'
  end
end
