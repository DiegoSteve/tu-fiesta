class Event < ApplicationRecord
    belongs_to :user
    has_many :guests, dependent: :destroy
    has_many :invitations, dependent: :destroy
    validates :name, uniqueness: { case_sensitive: false, message: "ya existe" }
    validates :date, presence: true
    validate :date_should_be_in_the_future
    validate :end_time_after_start_time

    def caducado?
      Date.current > date
    end
  
    private
  
    def date_should_be_in_the_future
      return if date.blank?
  
      errors.add(:date, "debe ser la fecha de hoy o en el futuro") if date < Date.current
    end
  
    def end_time_after_start_time
      return if start_time.blank? || end_time.blank?
  
      errors.add(:end_time, "debe ser después de la hora de inicio") if end_time <= start_time
    end

end
