class QuestionMailer < ApplicationMailer
  def creation_email(question)
    @question = question
    mail(
      subject: '質問作成完了メール',
      to: 'telva0527@gmail.com',
      from: 'questionapp@example.com'
    )
  end
end
