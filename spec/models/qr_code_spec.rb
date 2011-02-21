# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QrCode, 'associations' do
#  it { should belongs_to(:line_item) }
end

describe QrCode, "create_for_order" do

  context "validate unques of line_item" do
    before(:each) do
      @line_item = Factory(:line_item)
      Factory(:qr_code, :line_item => @line_item)
    end
    it "should be invalid with dublicated line_tem" do
      lambda{Factory(:qr_code, :line_item => @line_item).should}.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Line item has already been taken")
    end
  end

  context "with list_item with product with true generate_qr_code" do
    before(:each) do
      create_order_and_list_item_with_generate_qr_code(true)
    end

    it "should generate qr code for line_item" do
      @line_item.qr_code.should_not be_nil
      @line_item.qr_code.should == QrCode.last
    end
  end

  context "with list_item with product with false generate_qr_code" do
    before(:each) do
      create_order_and_list_item_with_generate_qr_code(false)
    end

    it "should generate qr code for line_item" do
      @line_item.qr_code.should be_nil
    end
  end

end

describe QrCode, "image" do
  before(:each) do
    @qr_code = Factory(:qr_code)
  end
  
  it "should return image" do
    @qr_code.image.should be_instance_of(String)
  end
end

def create_order_and_list_item_with_generate_qr_code(generate_qr_code)
  product = Factory(:product, :generate_qr_code => generate_qr_code)
  variant = Factory(:variant, :product => product)
  @line_item = Factory(:line_item, :variant => variant)
  @order = Factory(:order, :line_items => [@line_item])
  QrCode.create_for_order(@order)
end
