require 'spec_helper'

describe "directories/index.html.erb" do
  before(:each) do
    assign(:directories, [
      stub_model(Directory,
        :path => "Path", :modified_at => Time.now
      ),
      stub_model(Directory,
        :path => "Path", :modified_at => Time.now
      )
    ])
  end

  it "renders a list of directories" do
    render
    assert_select "tr>td", :text => "Path".to_s, :count => 2
  end
end
