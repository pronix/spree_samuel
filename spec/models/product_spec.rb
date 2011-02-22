require 'spec/spec_helper'

describe Product, 'associations' do
  #ToDo fix me
#  it { should belong_to(:seller) }
  it "should have generate_qr_code is true by default" do
    Product.new.generate_qr_code.should be_true
  end
end