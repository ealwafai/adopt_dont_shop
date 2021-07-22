class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  validates :breed, presence: true

  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.find_by_name(search)
    where('lower(name) LIKE ?', "%#{search.downcase}%")
  end

  def pet_application_status(app_id)
    PetApplication.find_apps(id, app_id).status
  end

  def approved?(app_id)
    pet_application_status(app_id) == 'approved'
  end

  def rejected?(app_id)
    pet_application_status(app_id) == 'rejected'
  end
end
