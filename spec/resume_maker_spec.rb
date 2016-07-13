require 'resume_maker'

describe 'ResumeMaker' do
  let(:maker) { ResumeMaker.new }

  it 'responds to the start call that starts the program' do
    expect(maker).to respond_to(:start)
  end

  it 'can set a user_io_handler' do
    expect(maker).to respond_to(:io_handler=).with(1)
  end

  it 'can set a plugin_handler' do
    expect(maker).to respond_to(:plugin_handler=).with(1)
  end

  describe '#display_main_menu_and_get_choice' do
    it 'gets a user choice from the list of items supplied' do
      io_handler = instance_double('UserIOHandler')
      allow(io_handler).to receive(:display_menu_and_get_choice)
        .and_return(1, 2, 3)
      maker.io_handler = io_handler
      expect(maker.display_main_menu_and_get_choice)
        .to eq(1)
      expect(maker.display_main_menu_and_get_choice)
        .to eq(2)
      expect(maker.display_main_menu_and_get_choice)
        .to eq(3)
    end
  end

  describe '#display_format_choice_menu_and_get_choice' do
    it 'displays the available formats and gets the user choice' do
      plugin_loader = instance_double('pluginLoader')
      allow(plugin_loader).to receive(:load_plugins)
      allow(plugin_loader).to receive(:list_plugins).and_return(
        %w(PDF CSV PlainText)
      )
    end
  end
end
