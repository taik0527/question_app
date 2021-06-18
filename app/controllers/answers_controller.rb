class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.new(answer_params.merge(question_id: params[:question_id]))
    @question = Question.find(params[:question_id])
    if @answer.save
      redirect_to @question, notice: "回答しました。"
    else
      @answer = Answer.new
      redirect_to @question, notice: "回答できません"
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
