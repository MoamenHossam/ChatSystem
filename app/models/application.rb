class Application < ApplicationRecord
    before_create :generate_token
    validates :name, presence: true
    validates :token, uniqueness: true

    
  
    def generate_token
      self.token = SecureRandom.uuid
      generate_token if Application.exists?(token: self.token)
    end
end
