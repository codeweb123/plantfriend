class User < ActiveRecord::Base
    has_secure_password #Macro that writes methods for password encryption and authentication.(Setter method for password)(def password=(string) encrypted_pw=BCrypt::Password.create(string) self.password_digest = encrypted_pw)
    validates :username, uniqueness: true 
    
    has_many :locations
    has_many :plants
end