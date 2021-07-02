class Question < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  scope :recent, -> { order(created_at: :desc) }
  belongs_to :user, optional: true
  has_many :answers, dependent: :destroy
end
