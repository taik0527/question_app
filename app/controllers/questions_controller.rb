class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
  end

  def solved
  end

  def unsolved
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to question_url(@question), notice: "投稿「#{@question.title}」を追加しました。"
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = Answer.where(question_id: params[:id]).order(created_at: "DESC")
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    @question.update!(question_params)
    redirect_to questions_url, notice: "質問「#{@question.title}」を更新しました。"
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy
    redirect_to questions_url, notice: "質問「#{@question.title}」を削除しました。"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
