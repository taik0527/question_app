class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.new(answer_params.merge(question_id: params[:question_id]))
    if @answer.save!
      redirect_to questions_url, notice: "回答しました。"
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
