module ApplicationHelper

    require "rqrcode"
    require "rqrcode_png"
    require "chunky_png"

    def qrcode(url)
        if Rails.env.production?
            # 本番環境の場合
            qrcode = RQRCode::QRCode.new("https://managing-app.onrender.com#{url}")
        elsif Rails.env.development?
            # 開発環境の場合
            qrcode = RQRCode::QRCode.new("http://localhost:3000#{url}")
        end

        return ChunkyPNG::Image.from_datastream(qrcode.as_png.resize(200,200).to_datastream).to_data_url
    end
end
