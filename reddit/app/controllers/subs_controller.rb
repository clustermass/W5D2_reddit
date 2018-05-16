class SubsController < ApplicationController
  before_action :require_sign_in
  
  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.erros.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    
  end

  def update
    @sub = current_user.subs.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.erros.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def index
    @sub = Sub.all
  end
  
  private
  
  
  def sub_params
    params.require(:sub).permit(:title,:description)
  end
  
end
