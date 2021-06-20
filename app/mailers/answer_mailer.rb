class AnswerMailer < ApplicationMailer

  def send_mail(user, answer)
    mail(subject: '回答作成完了メール' ,to: user.email, from: "questionapp@example.com")
  end

  def self.send_mail_user(answer, question)
    user = User.find(question.user_id)
    AnswerMailer.send_mail(user, answer).deliver_now
    answers = Answer.where(question_id: answer.question_id)
    user_ids = answers.pluck(:user_id).uniq!
    @users = User.where(id: user_ids)
    @users.each do |user|
      unless answer.user_id == user.id
        AnswerMailer.send_mail(user, answer).deliver_now
      end
    end
  end
end
