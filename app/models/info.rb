
class Info < ApplicationRecord\

    #before_create :set_address

    #def set_address
    #  return if latitude.blank? || longitude.blank?
        #results = Geocoder.search([latitude, longitude], language: :ja)
        #if results.present?
        #self.address = results.first.address
        #else
        #self.address = "住所が見つかりませんでした"
        #end
    #end
end
