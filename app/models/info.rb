
class Info < ApplicationRecord\

    belongs_to :user  

    before_create :generate_access_token

    validates :identifier, 
               presence: true,
               format: { with: /\A\d{10}\z/, message: "半角数字10桁で入力してください" }



    private
  
    def generate_access_token
      self.access_token = SecureRandom.hex(10) unless self.access_token.present?
    end
    
end
