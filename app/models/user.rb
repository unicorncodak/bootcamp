require 'bcrypt'
class User < ApplicationRecord
    
    EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
    validates :username, presence:true, :uniqueness => true, :length => { :in => 3..20 }
    validates :password, presence:true, length: { minimum: 6 }, on: :create
    validates :email, presence:true, :uniqueness => true, :format => EMAIL_REGEX
    has_secure_password

    has_many :assignments  
    has_many :roles, through: :assignments
    has_many :project
    has_many :comment
    has_many :team

    def role?(role)  
        roles.any? { |r| r.name.underscore.to_sym == role }  
    end
end
