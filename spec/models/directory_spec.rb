require 'spec_helper'

describe Directory do
  it { Directory.new.should be_a_new(Directory) }
end
