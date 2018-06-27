module PostsHelper

  def create_new_post_partial_path #this determines which partial file to render
  if user_signed_in?
    'posts/branch/create_new_post/signed_in'
  else
    'posts/branch/create_new_post/not_signed_in'
  end
end

def all_categories_button_partial_path
  if params[:category].blank?
    'posts/branch/categories/all_selected'
  else
    'posts/branch/categories/all_not_selected'
  end
end

def no_posts_partial_path #If posts are not found, the method will display a message.
  @posts.empty? ? 'posts/branch/no_posts' : 'shared/empty_partial'
end

end
