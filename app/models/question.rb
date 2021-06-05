class Question < ApplicationRecord
  scope :recent, -> { order(created_at: :desc) }
  belongs_to :users, optional: true
  has_many :answers
end
