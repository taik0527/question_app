class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.new(answer_params.merge(question_id: params[:question_id]))
    if @answer.save
      unless current_user.mine?(@answer.question)
        QuestionMailer.with(user: @answer.question.user, question: @answer.question).answer_created.deliver_later
      end

      User.related_to_question(@answer.question).distinct.each do |user|
        next if user.id == current_user.id || user.mine?(@answer.question)

        AnswerMailer.with(user: user, question: @answer.question).answer_created.deliver_later
      end
      redirect_to question_url(params[:question_id]), notice: "回答しました"
    else
      @question = @answer.question
      @answers = Answer.where(question_id: @question.id).order(created_at: "DESC")
      flash.now[:danger] = "回答の作成に失敗しました"
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
