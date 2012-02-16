require 'spec_helper'

describe Photo do
  it { Photo.new.should be_a_new(Photo) }
end
