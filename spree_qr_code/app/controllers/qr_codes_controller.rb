class QrCodesController < ApplicationController
  def show
    image = QrCode.find_by_code(params[:id]).try(:image, (params[:size]||QrCode::SMALL_SIZE ).to_i)
    if image
      send_data image, :filename => 'icon.jpg', :type => 'image/jpeg', :disposition => 'inline'
    else
      render :text => "Not found", :status => 404
    end
  end
end
