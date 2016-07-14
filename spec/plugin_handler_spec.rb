require 'plugin_handler'

describe PluginHandler do
  let(:plugin_handler) { PluginHandler.new }
  describe '#load_plugins' do
    it 'loads plugins from specified directory' do
      plugin_handler.load_plugins('spec/dummy_plugins')
      expect(plugin_handler.list_plugins.length).not_to eq(0)
    end
  end
  it 'responds to export' do
    expect(plugin_handler).to respond_to(:export)
  end
  it 'responds to list_plugins with an array' do
    expect(plugin_handler.list_plugins).to be_a(Array)
  end
  it 'responds to current_format=' do
    expect(plugin_handler).to respond_to(:current_format=)
  end
  it 'responds to load_plugins' do
    expect(plugin_handler).to respond_to(:load_plugins)
  end
  it 'responds to load_classes_from_folder' do
    expect(plugin_handler).to respond_to(:load_classes_from_folder)
  end
end
