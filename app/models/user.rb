class User < ApplicationRecord
    has_secure_password validations: false

    validates :name, presence: true, length: { minimum: 3 }
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }
end
