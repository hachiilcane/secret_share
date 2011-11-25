require 'spec_helper'

describe "directories/edit.html.erb" do
  before(:each) do
    @directory = assign(:directory, stub_model(Directory,
      :path => "MyString"
    ))
  end

  it "renders the edit directory form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => directories_path(@directory), :method => "post" do
      assert_select "input#directory_path", :name => "directory[path]"
    end
  end
end
