require 'spec/spec_helper'

describe Product, 'associations' do
  #ToDo fix me
#  it { should belong_to(:seller) }
end

describe Product, "qr_code" do
  before(:each) do
    @product = Factory(:product)
  end

  context "after create" do
    it "should generate qr_code" do
      @product.qr_code.should_not be_nil
    end
  end

  context "on update" do
    it "should not update qr_code" do
      qr_code = @product.qr_code
      @product.update_attributes!(:name => "new_name")
      @product.qr_code.should == qr_code
    end
  end

end