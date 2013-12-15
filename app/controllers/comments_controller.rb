class CommentsController < ApplicationController



	def show    
    @post  = Post.find(params[:id]) 
    @topic = Topic.find(params[:topic_id])
    @topic = Comments.find(params[:topic_id])
  end


	def create

	@topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    @new_comment = Comment.new
  	@comments= Comments.new(params[:comments])
    authorize! :create, @comments message: "You need to be signed in to do that."
  	if @comments.save
  		flash[:notice] = "Comment was saved successfully"
  		redirect_to @comments
  	else
  		flash[:error] = "There was an error creating the comment. Please try again"
  		render :new 
  	end
  end


    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
end
