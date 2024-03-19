Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }

  get '/about', to: 'landing_pages#default', as: 'landingPage'
  root to: redirect('/about')

  get 'home', to: 'posts#recent_posts', as: 'homePage'

  # Featured posts
  get 'posts/featured', to: 'posts#featuredPosts', as: 'featured_posts'

  # Admin Routes
  get 'admin/categories', to: 'categories#list', as: 'categories'
  post 'admin/categories', to: 'categories#create'
  get 'admin/categories/new', to: 'categories#new', as: 'new_category'
  get 'admin/categories/:id/edit', to: 'categories#edit', as: 'edit_category'
  patch 'admin/categories/:id', to: 'categories#update', as: 'category'
  get 'admin/flagged-posts', to: 'flag_posts#show', as: 'flagged_posts'
  post 'admin/flagged-posts/:post_id', to: 'flag_posts#remove', as: 'remove_flagged_post'

  # posts search
  get 'posts/search', to: 'posts#searchPosts', as: 'posts_search'

  # posts by category
  get 'posts/bycategory', to: 'posts#findPostByCategory', as: 'posts_category'
  get 'posts/myposts', to: 'posts#myPosts', as: 'my_posts'

  # react to posts


  # posts
  get 'posts/new', to: 'posts#new', as: 'new_post'
  post 'posts/new', to: 'posts#create'
  delete 'posts/myshelf/:post_id', to: 'posts#deleteMyShelfPost', as: 'delete_myshelf_post'
  get 'posts/myshelf', to: 'posts#showMyShelf', as: 'my_shelf'
  get 'posts/:post_id', to: 'posts#show', as: 'show_post'
  post 'posts/:post_id/react/:react_action/', to: 'posts#reactPost', as: 'react_post'

  get 'posts/:post_id/step', to: 'posts#step', as: 'new_step'
  post 'posts/:post_id/step', to: 'posts#createStep'
  patch 'posts/:post_id/edit', to: 'posts#updatePost'
  get 'posts/:post_id/edit', to: 'posts#editPost', as: 'edit_post'
  get 'posts/:post_id/step/:step_id', to: 'posts#editStep', as: 'edit_step'
  patch 'posts/:post_id/step/:step_id', to: 'posts#updateStep'
  delete 'posts/:post_id/step/:step_id', to: 'posts#destroyStep'
  post 'posts/:post_id/flag', to: 'posts#flagPost', as: 'flag_post'
  delete 'posts/:post_id', to: 'posts#deletePost', as: 'delete_post'
  post 'posts/:post_id/save', to: 'posts#savePosts', as: 'save_post' 

  # author profile
  get 'authors/:id', to: 'posts#authorProfile', as: 'author_profile'
  
  #comments
  post 'posts/:post_id/comment', to: 'posts#createComment', as: 'new_comment'

  #Messages
  get 'message/users', to: 'messages#allMessages', as: 'all_messages'
  get 'message/:author_id', to: 'messages#index', as: 'messages'
  post 'message/:author_id', to: 'messages#sendMessage'

end
