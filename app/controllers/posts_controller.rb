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
  branch = params[:action]
  search = params[:search]
  category = params[:category]

  if category.blank? && search.blank?
    posts = Post.by_branch(branch).all
  elsif category.blank? && search.present?
    posts = Post.by_branch(branch).search(search)
  elsif category.present? && search.blank?
    posts = Post.by_category(branch, category)
  elsif category.present? && search.present?
    posts = Post.by_category(branch, category).search(search)
  else
  end
end

end #end post controller class
