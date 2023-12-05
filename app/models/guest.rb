class Guest < ApplicationRecord
    belongs_to :event
    has_many :invitations
    validates :table, numericality: { only_integer: true, greater_than_or_equal_to: 0 , message:"ingresa el numero de mesa positivo"}
    validates :telephone, length: { is: 10, message:"tiene mas de 10 digitos" }, numericality: { only_integer: true }
end
