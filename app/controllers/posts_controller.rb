class PostsController < ApplicationController

  def show
  @post = Post.find(params[:id])
end

def inspiration
  posts_for_branch(params[:action])
end

def recipes
  posts_for_branch(params[:action])
end

def tiugirls #this calls a method which will return data for the specific page depending on the actions name
  posts_for_branch(params[:action])
end

private

def posts_for_branch(branch) #retrieving all categories for the branch
  @categories = Category.where(branch: branch)
  @posts = get_posts.paginate(page: params[:page])
end

def get_posts #gets posts 
  Post.limit(30)
end

end #end post controller class
