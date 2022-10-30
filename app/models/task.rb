class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 300 }
  # default_scope -> { order(created_at: :desc) }
  # scope :deadline_sorted, -> { order(deadline: :desc) }
  enum status: { 未着手:0, 着手中:1, 完了:2 }
  # def self.search(keyword)
  #   where(['title LIKE(?)', "%#{params[:keyword]}%"])
  # end
  scope :title_search, -> (title) { where("title LIKE ?", "%#{title}%") if title.present? }
  scope :status_search, -> (status) { where(status: status) if status.present? }
  scope :search_and, -> (title, status) { where("title LIKE ?", "%#{title}%").where(status: status) if title.present? && status.present? }
end
