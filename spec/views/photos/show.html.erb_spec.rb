require 'spec_helper'

describe "photos/show.html.erb" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :full_name => "File Name",
      :directory_id => 1,
      :directory => stub_model(Directory,
                               :path => 'photodir',
                               :modified_at => Time.now,
                               :is_ready_for_detail => false)                                       
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/File Name/)
  end
end
