require 'spec_helper'

describe "photos/new.html.erb" do
  before(:each) do
    assign(:photo, stub_model(Photo,
      :file_name => "MyString",
      :directory_id => 1
    ).as_new_record)
  end

  it "renders new photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => photos_path, :method => "post" do
      assert_select "input#photo_file_name", :name => "photo[file_name]"
      assert_select "input#photo_directory_id", :name => "photo[directory_id]"
    end
  end
end
