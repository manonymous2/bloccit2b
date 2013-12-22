class CommentsController < ApplicationController

before_filter :authenticate_user! 

	def create
	  @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments
   
    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    @new_comment = Comment.new
    


  	if @comment.save
  		flash[:notice] = "Comment was saved successfully"
  		redirect_to :back
  	else
  		flash[:error] = "There was an error creating the comment. Please try again"
  		render :new 
  	end
   end
  


    def destroy
       @topic = Topic.find(params[:topic_id])
       @post = @topic.posts.find(params[:post_id])
       @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end

end
