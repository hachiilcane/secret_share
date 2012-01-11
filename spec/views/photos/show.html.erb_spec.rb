require 'spec_helper'

describe "photos/show.html.erb" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :full_name => "File Name",
      :directory_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/File Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
