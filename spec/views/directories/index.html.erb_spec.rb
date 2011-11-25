require 'spec_helper'

describe "directories/index.html.erb" do
  before(:each) do
    assign(:directories, [
      stub_model(Directory,
        :path => "Path"
      ),
      stub_model(Directory,
        :path => "Path"
      )
    ])
  end

  it "renders a list of directories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Path".to_s, :count => 2
  end
end
