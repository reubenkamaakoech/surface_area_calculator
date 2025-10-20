class Section < ApplicationRecord
  belongs_to :user
  has_many :room_sections, dependent: :destroy
  has_many :rooms, through: :room_sections

  after_create :add_to_existing_rooms

  private

  def add_to_existing_rooms
    Room.find_each do |room|
      RoomSection.create(room: room, section: self)
    end
  end
end
