# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Order, "finalize" do
  before(:each) do
    @order = Factory(:order, :state => "confirm")
  end

  it "should generate qr_code for order" do
    QrCode.should_receive(:create_for_order).at_least(:once).with(@order)
    @order.next
  end

end

