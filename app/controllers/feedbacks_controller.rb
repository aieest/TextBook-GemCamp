class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.all
  end

  def contact
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback].permit(:name, :email, :message))
    if @feedback.save
      redirect_to feedbacks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @feedback = Feedback.find(params[:id])
  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update(params.require(:feedback).permit(:name, :email, :message))
      flash[:notice] = 'Post updated successfully'
      redirect_to feedbacks_path
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    flash[:notice] = 'Feedback destroyed successfully'
    redirect_to feedbacks_path
  end
end