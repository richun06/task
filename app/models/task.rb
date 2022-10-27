class Task < ApplicationRecord
  validates :title, presence: true, length: { maximun: 20 }
  validates :content, presence: true, length: { maximun: 300 }
end
