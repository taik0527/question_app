class QuestionMailer < ApplicationMailer

  def send_mail(user, question)
    @question = question
    mail(subject: '質問作成完了メール' ,to: user.email, from: "questionapp@example.com")
  end

  def send_mail_users(question)
    @users = User.all
    @users.each do |user|
      unless question.user_id == user.id
        QuestionMailer.send_mail(user, question).deliver_now
      end
    end
  end
end
