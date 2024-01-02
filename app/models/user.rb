class User < ApplicationRecord
    has_secure_password
  
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    before_save { self.email.downcase! }
  
    validates :name, presence: true, length: { minimum: 5, maximum: 50 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true, length: { minimum: 7 }, if: -> { new_record? || !password.nil? }
    validate :password_contain_number, if: -> { new_record? || !password.nil? }
  
    private
      def password_contain_number
        return if password =~ /\d/
        errors.add(:password, 'パスワードは7文字以上で、数字を少なくとも1つ含める必要があります。')
      end
end
  