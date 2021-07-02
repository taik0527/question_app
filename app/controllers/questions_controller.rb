class QuestionsController < ApplicationController
  before_action :set_question, {only:[:edit, :update, :destroy]}

  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def solved
    @q = Question.where(solved: true).ransack(params[:q])
    @questions = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    render :index
  end

  def unsolved
    @q = Question.where(solved: false).ransack(params[:q])
    @questions = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
    render :index
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      User.all.each { |user| QuestionMailer.with(user: user, question: @question).question_created.deliver_later }
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
  end

  def update
    if @question.update(question_params)
      redirect_to question_url(@question), notice: "質問「#{@question.title}」を更新しました。"
    else
      flash.now[:danger] = "失敗しました"
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: "質問「#{@question.title}」を削除しました。"
  end

  def solve
    @question = current_user.questions.find(params[:id])
    @question.update!(solved: true)
    redirect_to question_path(@question), success: '解決済みにしました'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = current_user.questions.find(params[:id])
  end
end
