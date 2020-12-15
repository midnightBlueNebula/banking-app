class User < ApplicationRecord
    attr_accessor :remember_token

    has_many :logs, dependent: :destroy
    has_many  :checking_accounts, dependent: :destroy
    has_many :savings_accounts, dependent: :destroy
    has_many :depts, dependent: :destroy

    before_save { email.downcase! }

    validates :name, presence: true, length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, presence: true, length: { maximum: 255 }, 
                                format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }                                 

    has_secure_password   

    validates :password, presence: true, length: { minimum: 6, maximum: 50 }

    class << self
    
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost                                                          
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end

    end

    def remember 
        @remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def set_online
        update_attribute(:online, true)
    end

    def set_offline
        update_attribute(:online, false)
    end
end
