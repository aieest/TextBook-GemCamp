class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all

    if params[:title].present?
      @posts = @posts.where("title LIKE ?", "%#{params[:title]}%")
    end

    if params[:start_date].present?
      @posts = @posts.where("created_at >= ?", Date.parse(params[:start_date]))
    end

    if params[:end_date].present?
      @posts = @posts.where("created_at <= ?", Date.parse(params[:end_date]))
    end

    if params[:published] == "1"
      @posts = @posts.where(published: true)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

    @post.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end