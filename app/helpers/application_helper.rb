module ApplicationHelper

    require "rqrcode"
    require "rqrcode_png"
    require "chunky_png"

    def qrcode(info)
        Rails.logger.debug "qrcode method received: #{info.inspect}" # デバッグ出力

        unless info.is_a?(Info)
            Rails.logger.error "❌ qrcode method received invalid object: #{info.class}"
            return nil
        end

        # トークンが未設定の場合は生成して保存
        if info.access_token.blank?
          info.update(access_token: SecureRandom.hex(16))
        end
      
        base_url = Rails.application.routes.url_helpers.root_url(host: Rails.application.routes.default_url_options[:host])
        qr_url = "#{base_url}infos/read_only/#{info.id}?token=#{info.access_token}"
        
        qrcode = RQRCode::QRCode.new(qr_url)
        qrcode.as_png(border_modules:0, size: 300).to_data_url
    end
      
end
