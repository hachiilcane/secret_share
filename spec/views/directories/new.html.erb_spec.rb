require 'spec_helper'

describe "directories/new.html.erb" do
  before(:each) do
    assign(:directory, stub_model(Directory,
      :path => "MyString"
    ).as_new_record)
  end

  it "renders new directory form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => directories_path, :method => "post" do
      assert_select "input#directory_path", :name => "directory[path]"
    end
  end
end
