class CommentsController < ApplicationController



	def create

	@topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    @new_comment = Comment.new
    authorize! :create, @comments message: "You need to be signed in to do that."
  	if @comments.save
  		flash[:notice] = "Comment was saved successfully"
  		redirect_to @comments
  	else
  		flash[:error] = "There was an error creating the comment. Please try again"
  		render :new 
  	end
  end
end


    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
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
