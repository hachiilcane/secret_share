require 'spec_helper'

describe "photos/edit.html.erb" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :full_name => "MyString",
      :directory_id => 1
    ))
  end

  it "renders the edit photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => photos_path(@photo), :method => "post" do
      assert_select "input#photo_full_name", :name => "photo[full_name]"
      assert_select "input#photo_directory_id", :name => "photo[directory_id]"
    end
  end
end
