require 'spec_helper'

describe "photos/index.html.erb" do
  before(:each) do
    assign(:photos, [
      stub_model(Photo,
        :full_name => "File Name",
        :directory_id => 1
      ),
      stub_model(Photo,
        :full_name => "File Name",
        :directory_id => 1
      )
    ])
  end

  it "renders a list of photos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
