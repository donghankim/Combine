class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :movie
         has_many :game
         has_many :podcast
         has_many :tv_show
         has_many :friend
         has_many :media
end
