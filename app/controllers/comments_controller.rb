class CommentsController < ApplicationController
  #before_filter :authenticate_user!, :on => :destroy
  def show
    #@post = Post.find(params[:post_id])
    redirect_to post_path
  end
  
  def create
    @post     = Post.find(params[:post_id])
    @comment  = @post.comments.create! params[:comment]
    
    redirect_to post_path(@post)
    
  end
  
  def destroy
    @post     = Post.find(paras[:post_id])
    @comment  = @post.comments.find(params[:comment])
    @comment.destroy
    
    redirect_to post_path(@post)
    
  end
end
