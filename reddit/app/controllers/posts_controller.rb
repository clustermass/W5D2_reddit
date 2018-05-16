class PostsController < ApplicationController
    
  before_action :require_sign_in
    
  def new
    @post = Post.new
    @subjects = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    
    # @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
      @subjects = Sub.all
      @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def index
    @subjects = Sub.all
    @post = Post.all
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end 

end
