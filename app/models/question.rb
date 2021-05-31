class Question < ApplicationRecord
  belongs_to :users
  has_many :answers
end
