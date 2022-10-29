class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 300 }
  # default_scope -> { order(created_at: :desc) }
  # scope :deadline_sorted, -> { order(deadline: :desc) }
  enum status: { 未着手:0, 着手中:1, 完了:2 }
end
