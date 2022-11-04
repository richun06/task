class User < ApplicationRecord
  before_destroy :admin_exist_check
  before_update :admin_update_exist
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :new

  def admin_exist_check
    if User.where(admin:true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end

  def admin_update_exist
    if User.where(admin:true).count == 1 && self.admin == [true, false]
      throw(:abort)
    end
  end
end
