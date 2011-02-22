# qrimage.rb $Revision: 1.0 $: Create QRImage Data
#
# Copyright (C) 2009 M.Yoshikawa <hal99>
# You can redistribute it and/or modify it under MIT Licence
#
# Dependence
# - rqrcode 0.3.2 or more
# - RMagick 2.9.2 or more

require 'rubygems'
require 'rqrcode'
require "RMagick"


module QRImage
  include Magick
  def create_qr(str,opt={})
    # コード作成用定数
    opt[:size] ||= 4
    opt[:level] ||= :h
    opt[:pic] ||= 2
    opt[:format] ||= "jpg"
    opt[:back_color] ||= "#ffffff"
    opt[:code_color] ||= "#000000"
    # QRコード作成
    qr = RQRCode::QRCode.new(str,{:size=>opt[:size],:level=>opt[:level]})
    # 背景画像作成
    img_height = img_width = qr.modules.size*opt[:pic]
    img = Image.new(img_width,img_height) {|i|i.background_color = opt[:back_color]}
    # 塗りつぶしよう画像作成
    fill_img = Image.new(opt[:pic],opt[:pic]) {|i|i.background_color=opt[:code_color]}
    # QRコード画像作成
    qr.modules.each_index do |x|
      qr.modules.each_index do |y|
        if qr.is_dark(y,x)
          img = img.composite(fill_img,x*opt[:pic],y*opt[:pic],Magick::OverCompositeOp)
        end
      end
    end
    # 出力フォーマット指定
    img.format = opt[:format]
    # QR画像書き出し
    return img.to_blob
  end
  module_function :create_qr
end