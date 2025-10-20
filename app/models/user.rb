class User < ApplicationRecord
  has_many :sites, dependent: :destroy
  has_many :area_types, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :sections, dependent: :destroy
  has_many :area_types, dependent: :destroy

  
  has_one_attached :image

  validates :username, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable, :trackable, :timeout_in => 20.minutes

  def  self.online
    where("last_seen_at >= ?", 10.minutes.ago)
  end
  
   def online?
    last_seen_at && last_seen_at > 10.minutes.ago
  end
        
   # Example roles: admin, manager, staff, employee
  ROLES = %w[admin manager staff employee]

  def self.categories
    ROLES
  end

  def admin?
    role == 'admin'
  end

  def manager?
    role == "manager"
  end

  def staff?
    role == "staff"
  end

  def employee?
    role == "employee"
  end

  def can_access_data?
    access_granted?
  end

  def access_granted?
    admin? || self[:access_granted]
  end

  def active_for_authentication?
    super && status?
  end

  def inactive_message
    status? ? super : :account_inactive
  end  
end
