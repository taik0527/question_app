class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def solved
  end

  def unsolved
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def destroy
  end
end
