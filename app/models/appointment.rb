class Appointment < ApplicationRecord
  validates :data, presence: true, uniqueness: true
  validates :nome, :telefone, presence: true
  
  scope :for_month, ->(year, month) { 
    where(data: Date.new(year, month, 1)..Date.new(year, month, -1)) 
  }
  
  def self.date_available?(data)
    !exists?(data: data) && data >= Date.today
  end
end
