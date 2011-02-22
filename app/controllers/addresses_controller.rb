class AddressesController < Spree::BaseController

  before_filter :load_data
  before_filter :build_address, :only => [:edit, :update]

  def show
    redirect_to edit_addresses_path(@address_type) and return if @address.blank?
  end

  def update
    @address.attributes = params[:address]
    if @address.save && current_user.update_attribute(:bill_address_id, @address.id)
      redirect_to addresses_path(@address_type), :notice => "Successfully Updated."
    else
      render :action => :edit
    end
  end

  private

  def load_data
    @address_type = params[:address_type].to_sym
    redirect_to account_path and return unless @address_type.to_s =~ /bill|ship/
    @address = current_user.send(:"#{@address_type}_address")
  end

  def build_address
    @address ||= current_user.send(:"build_#{@address_type}_address")
  end

end


