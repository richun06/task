class Task < ApplicationRecord
  belongs_to :user
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

  enum priority: { 高:0, 中:1, 低:2 }

  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  # scope :label_search, -> (label) {
  #   return if label.blank?
  #   # joins(:labels).where('labels.id = ?', label)
  #   where(id: LabelTask.where(label_id: label).select(:task_id))
  # }
end
