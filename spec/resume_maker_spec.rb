require 'resume_maker'

describe 'ResumeMaker' do
  let(:maker) { ResumeMaker.new }

  it 'responds to the start call that starts the program' do
    expect(maker).to respond_to(:start)
  end

  it 'sets a user_io_handler' do
    expect(maker).to respond_to(:io_handler=).with(1)
  end

  it 'sets a plugin_handler' do
    expect(maker).to respond_to(:plugin_handler=).with(1)
  end

  describe '#display_main_menu_and_get_choice' do
    it 'gets a user choice from the list of items supplied' do
      io_handler = instance_double('UserIOHandler')
      allow(io_handler).to receive(:display_menu_and_get_choice).and_return(1,2,3)
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
      io_handler = instance_double('UserIOHandler')
      allow(io_handler).to receive(:display_menu_and_get_choice)
        .and_return(1,4,5)
      plugin_handler = instance_double('PluginHandler')
      allow(plugin_handler).to receive(:load_plugins)
      allow(plugin_handler).to receive(:list_plugins).and_return(
        %(PDF CSV PlainText)
      )

      maker.io_handler = io_handler
      maker.plugin_handler = plugin_handler
      expect(maker.display_format_choice_menu_and_get_choice).to eq(1)
      expect(maker.display_format_choice_menu_and_get_choice).to eq(4)
      expect(maker.display_format_choice_menu_and_get_choice).to eq(5)
    end
  end

  # split this
  describe '#export' do
    before(:example) do
      @io_handler = instance_double('UserIOHandler')
      allow(@io_handler).to receive(:ask_user_for).with(kind_of(String))
        .and_return('somename', 'someage', 'someplace', 'somefile')
      @plugin_handler = instance_double('pluginHandler')
      allow(@plugin_handler).to receive(:export).with(
        kind_of(User),
        kind_of(String)
      ).and_return('success')
      maker.io_handler = @io_handler
      maker.plugin_handler = @plugin_handler

      @result = maker.export
    end
    it 'asks io controller for filename' do
      expect(@io_handler).to have_received(:ask_user_for).with(kind_of(String))
    end
    it 'tells plugin_handler to export' do
      expect(@plugin_handler).to have_received(:export).with(
        kind_of(User),
        kind_of(String)
      )
    end
    it 'returns success ' do
      expect(@result).to eq('success')
    end
  end

  describe '#start' do
    before(:example) do
      @io_handler = instance_double('UserIOHandler')
      @plugin_handler = instance_double('PluginHandler')
      allow(@io_handler).to receive(:clear_screen)
      allow(@io_handler).to receive(:ask_user_for)
      allow(@plugin_handler).to receive(:current_format=)
      allow(@plugin_handler).to receive(:load_plugins)
      allow(@plugin_handler).to receive(:list_plugins)
    end
    it 'obtains user details when option 1 is chosen' do
      allow(@io_handler).to receive(:display_menu_and_get_choice)
        .and_return(1, 4)

      maker.io_handler = @io_handler
      maker.start
      expect(@io_handler).to have_received(:ask_user_for).with('Name')
    end
    it 'sets plugin when option 2 is chosen' do
      allow(@io_handler).to receive(:display_menu_and_get_choice)
        .and_return(2, 4)
      maker.io_handler = @io_handler
      maker.plugin_handler = @plugin_handler
      maker.start
      expect(@plugin_handler).to have_received(:current_format=)
        .with(kind_of(Numeric))
    end
    it 'asks plugin handler to export when option 3 is chosen' do
      allow(@io_handler).to receive(:display_menu_and_get_choice)
        .and_return(3, 4)
      allow(@plugin_handler).to receive(:export)
        .with(kind_of(User), anything)
      maker.io_handler = @io_handler
      maker.plugin_handler = @plugin_handler
      maker.start
      expect(@plugin_handler).to have_received(:export)
        .with(kind_of(User), anything)
    end
  end
end
