require "rails_helper"

RSpec.feature "Infinite scroll", :type => :feature do
  Post.per_page = 15

  let(:check_posts_count) do
    expect(page).to have_selector('.single-post-list', count: 15)
    page.execute_script("$(window).scrollTop($(document).height())")
    expect(page).to have_selector('.single-post-list', count: 30)
  end

  scenario "User scrolls down the inspiration page
            and posts list will be appended with older posts", js: true do
    create_list(:post, 30, category: create(:category, branch: 'inspiration'))
    visit inspiration_posts_path
    check_posts_count
  end

  scenario "User scrolls down the recipes page
            and posts list will be appended with older posts", js: true do
    create_list(:post, 30, category: create(:category, branch: 'recipes'))
    visit recipes_posts_path
    check_posts_count
  end

  scenario "User scrolls down the tiugirls page
            and posts list will be appended with older posts", js: true do
    create_list(:post, 30, category: create(:category, branch: 'tiugirls'))
    visit tiugirls_posts_path
    check_posts_count
  end

end
