require 'spec_helper'

describe "directories/show.html.erb" do
  before(:each) do
    @directory = assign(:directory, stub_model(Directory,
      :path => "Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Path/)
  end
end
