class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :guests, through: :events
  has_many :invitations

  def confirmed_attendance?(event)
    invitations.exists?(event: event, confirmed: true)
  end  
end
