class Room < ApplicationRecord
  belongs_to :user
  has_many :room_sections, dependent: :destroy
  has_many :sections, through: :room_sections

  after_create :add_existing_sections

  private

  def add_existing_sections
    Section.find_each do |section|
      RoomSection.create(room: self, section: section)
    end
  end
end
