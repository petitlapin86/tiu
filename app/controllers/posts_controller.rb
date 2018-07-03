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
  respond_to do |format|
  format.html
  format.js { render partial: 'posts/posts_pagination_page' }
end
end

def get_posts #gets posts
  PostsForBranchService.new({
       search: params[:search],
       category: params[:category],
       branch: params[:action]
     }).call
   end
   
end #end post controller class
