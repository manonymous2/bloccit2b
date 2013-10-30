class TopicsController < ApplicationController
  def index
  	@topics = Topic.all
  end

  def new
  	@topic = Topic.new
  	authorize! :create, @topic, message: "You need to be an admin to do that"
  end

  def show
  	@topic = Topic.find(params[:id])
    @posts = @topic.posts
  end

  def edit
  	@topic = Topic.find(params[:id])
    authrorize! :update, @topic, message: "You need to be an admin."
  end

  def create
  	@topic = Topic.new(params[:topic])
    authrorize! :create, @topic, message: "You need to be an admin."
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
    authroize! :update, @topic, message: "you need to be an admin"
  	if @topic.update_attributes(params[:topic])
  		redirect_to @topic
  	else
  		flash[:error] = "Error updating topic. Please try again"
  		render :edit
  	end
  end
end
