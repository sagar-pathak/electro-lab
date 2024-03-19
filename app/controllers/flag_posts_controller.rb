class FlagPostsController < ApplicationController

    before_action :authenticate_admin!, only: [:show] 

    layout "admin_layout"

    def authenticate_admin!
        unless user_signed_in? && current_user.admin?
            flash.alert = "Sorry, you don't have permissions to perform this action."
            redirect_to landingPage_url
        end
    end

    def show
        @all_flagged_posts = FlaggedPost.select(:post_id).group(:post_id).order('count_post_id desc').count(:post_id)
        @all_posts = Post.where(:isFlagged => false)
        render :show
    end 

    def remove
        @flagged_post_id = params[:post_id]
        @flagged_post = FlaggedPost.where(:post_id=> @flagged_post_id)
        if Post.where(:id => @flagged_post_id).update_all(:isFlagged => true)
            @flagged_post.destroy_all
            flash[:success] = "Post removed successfully!"
            redirect_to flagged_posts_url
        else
            flash.now[:error] = @post.errors.full_messages.join(", ")
            redirect_to remove_flagged_post(:post_id=>@flagged_post_id)
        end
    end

end
