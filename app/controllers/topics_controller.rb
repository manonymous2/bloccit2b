class TopicsController < ApplicationController
  def index
  	@topics = Topic.paginate(page: params[:page], per_page: 4)
  end

  def new
  	@topic = Topic.new
  	authorize! :create, @topic, message: "You need to be an admin to do that"
  end

  def show
  	@topic = Topic.find(params[:id])
     @posts = @topic.posts.paginate(page: params[:page], per_page: 4)
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to be an admin."
  end

  def create
  	@topic = Topic.new(params[:topic])
    authorize! :create, @topic, message: "You need to be an admin."
  	if @topic.save
  		flash[:notice] = "Topic was saved successfully"
  		redirect_to @topic 
  		#redirect_to @topic, notice: "Topic was saved successfully"
  	else
  		flash[:error] = "Error creating topic. Please try again"
  		render :new 
  	end
  end

  def update
  	@topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "you need to be an admin"
  	if @topic.update_attributes(params[:topic])
  		redirect_to @topic
  	else
  		flash[:error] = "Error updating topic. Please try again"
  		render :edit
  	end
  end
end
