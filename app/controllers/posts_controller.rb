class PostsController < ApplicationController
before_action :redirect_if_not_signed_in, only: [:new]

def show
   @post = Post.find(params[:id])
   if user_signed_in?
     @message_has_been_sent = conversation_exist?
   end
 end

def new
  @branch = params[:branch]
  @categories = Category.where(branch: @branch)
  @post = Post.new
end

def create
  @post = Post.new(post_params)
  if @post.save
    redirect_to post_path(@post)
  else
    redirect_to root_path
  end
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

   def post_params
  params.require(:post).permit(:content, :title, :category_id)
                       .merge(user_id: current_user.id)
end

def conversation_exist?
  Private::Conversation.between_users(current_user.id, @post.user.id).present?
end

end #end post controller class
