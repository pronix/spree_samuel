# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LineItem, 'associations' do
  it { should has_one(:qr_code) }
end
describe LineItem do
  before(:each) do
    @list_item = LineItem.new
  end

  it "should desc" do
    # TODO
  end
end

