class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  scope :related_to_question, ->(question) { joins(:answers).where(answers: { question_id: question.id }) }

  def mine?(object)
    object.user_id == id
  end
end
