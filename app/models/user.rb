class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shared_by_me, class_name: 'SharedLocation', foreign_key: :shared_by_id
  has_many :shared_with_me, class_name: 'SharedLocation', foreign_key: :shared_with_id
  has_many :locations, through: :shared_by_me
end
