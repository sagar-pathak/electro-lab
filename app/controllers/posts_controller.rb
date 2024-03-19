class PostsController < ApplicationController
    before_action :authenticate_user_only!

    layout "user_layout"

    def authenticate_user_only!

        @q = Post.ransack(params[:q])
        @category = Category.new

        unless user_signed_in? && !current_user.admin?
            flash.alert = "Sorry, you don't have permissions to perform this action."
            redirect_to landingPage_url
        end
    end

    def recent_posts
        @votes = Vote.all
        @posts = Post.where(:isFlagged => false).order(created_at: :desc)
        @my_shelf_post = MyShelfPost.new
        render :recent_posts
    end

    def findPostByCategory
        @votes = Vote.all
        @posts = Post.where(:category_id => params[:category][:id], :isFlagged => false)
        @category = Category.find(params[:category][:id])
        render :category_posts
    end

    #new posts
    def new
        @post = Post.new
        @categories = Category.all
        render :new_post
    end

    def create
        @post = current_user.posts.build(params.require(:post).permit(:title, :description, :category_id, :thumbnailImg, :isFlagged))
        if @post.save
            flash[:success] = "New post successfully created!"
            redirect_to new_step_url(post_id: @post.id)
        else
            flash.now[:error] = @post.errors.full_messages.join(", ")
            render :new_post
        end
    end

    def step
        @step = Step.new
        @steps = Step.where(:post_id=>params[:post_id])
        @post = Post.find(params[:post_id])
        render :new_step
    end

    def createStep
        @post = Post.find(params[:post_id])
        @step = @post.steps.build(params.require(:step).permit(:title, :description, :image))
        if @step.save
            flash[:success] = "New step successfully added!"
            redirect_to new_step_url(post_id: @post.id)
        else
            flash.now[:error] = @post.errors.full_messages.join(", ")
            render :new_post
        end
    end

    def editStep
        @post = Post.find(params[:post_id])
        @step = Step.find(params[:step_id])
        render :edit_step
    end

    def updateStep
        @post = Post.find(params[:post_id])
        @step = Step.find(params[:step_id])

        if @step.update(params.require(:step).permit(:title, :description, :image))
            flash[:success] = "Step successfully updated!"
            redirect_to new_step_url(post_id: @post.id)
        else
            flash.now[:error] = @post.errors.full_messages.join(", ")
            render :edit_step
        end
    end

    def destroyStep
        @post = Post.find(params[:post_id])
        @step = Step.find(params[:step_id])
        @step.destroy
        flash[:success] = "The step was successfully removed."
        redirect_to new_step_url(post_id: @post.id)
    end

    def show
        @post = Post.find(params[:post_id])
        @steps = Step.where(:post_id=>@post.id)
        @comment = Comment.new;
        @comments = Comment.where(:post_id=>@post.id)
        @category = Category.new
        @flagged_post = FlaggedPost.new
        @flagged_posts = FlaggedPost.where(:post_id=>@post.id, :user_id=>current_user.id).limit(1)
        render :show_post
    end

    # search posts
    def searchPosts
        @search_param = params[:q]
        
        @posts = @q.result(distinct: true).where(:isFlagged => false).order('created_at desc')
        @votes = Vote.all
        render :search_posts
    end

    def authorProfile
        @author = User.find(params[:id])
        @posts = Post.where(user_id: params[:id])
        @votes = Vote.all
        
        render :author_profile

        
    end

    def createComment
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(params.require(:comment).permit(:feedback))
        @comment.user_id = current_user.id
        if @comment.save
            flash[:success] = "Comment added!"
            redirect_to show_post_url(post_id: @post.id)
        else
            flash[:error] = @comment.errors.full_messages.join(", ")
            redirect_to show_post_url(post_id: @post.id)
        end
        
    end 

    def flagPost
        @post = Post.find(params[:post_id])
        @flaggedPost = @post.flagged_posts.build()
        @flaggedPost.user_id = current_user.id
        if @flaggedPost.save
            flash[:success] = "This post has been reported. Thanks"
            redirect_to show_post_url(post_id: @post.id)
        else
            flash[:error] = "This post has been reported already. Thanks"
            redirect_to show_post_url(post_id: @post.id)
        end
    end

    def reactPost
        @votePost = Vote.new(post_id: params[:post_id])
        @votePost.user_id = current_user.id

        action = params[:react_action].to_i
        if action == 1
            @votePost.upvote = 1
            if hasVoted?(params[:post_id] ,current_user.id ) 
                Vote.where(post_id: params[:post_id], user_id: current_user.id).destroy_all 
            end 
            if !@votePost.save
                flash[:error] = "Cannot Upvote at the moment"
            end
            
        end

        if action == 2
            @votePost.downvote = 1
            if hasVoted?(params[:post_id] ,current_user.id ) 
                Vote.where(post_id: params[:post_id], user_id: current_user.id).destroy_all 
            end
            if !@votePost.save
                flash[:error] = "Cannot Downvote at the moment"
            end
        end
        redirect_to request.referer

    end

    def hasVoted?(post_id, user_id)
        !Vote.where(post_id: post_id, user_id: user_id).empty?
    end

    def featuredPosts
        @mostLikes = Vote.select(:post_id).group(:post_id).order('sum_upvote DESC').sum(:upvote)
        @posts = @mostLikes.keys.collect {|i| Post.find(i) if @mostLikes[i] != 0 }.compact
        @votes = Vote.all
        render :featured_posts
    end

    def myPosts
        @posts = Post.where(user_id: current_user.id)
        render :my_posts
    end

    def editPost
        @post = Post.find(params[:post_id])
        @steps = Step.where(:post_id=>@post.id)
        render :edit_post
    end

    def updatePost
        @post = Post.find(params[:post_id])

        if @post.update(params.require(:post).permit(:title, :description))
            flash[:success] = "Post successfully updated!"
            #redirect_to show_post_url(post_id: @post.id)
            redirect_to new_step_url(post_id: @post.id)
        else
            flash.now[:error] = @post.errors.full_messages.join(", ")
            render :edit_post
        end
    end

    def deletePost
        @post = Post.find(params[:post_id])
        @post.destroy
        flash[:success] = "The Post is deleted."
        redirect_to my_posts_url
    end

    def savePosts
        @post_id = params[:post_id]
        @my_shelf_post = MyShelfPost.new
        @my_shelf_post.post_id = @post_id
        @my_shelf_post.user_id = current_user.id

        if @my_shelf_post.save
            flash[:success] = "Post successfully added to my shelf."
            redirect_to request.referer
        else
            flash[:error] = @my_shelf_post.errors.full_messages.join(", ")
            redirect_to request.referer
        end
    end 

    def showMyShelf
        @my_shelf_post_ids = MyShelfPost.select(:post_id).where(user_id: current_user.id).pluck(:post_id)
        @posts = Post.where(id: @my_shelf_post_ids)
        render :my_shelf
    end 

    def deleteMyShelfPost
        @post_id = params[:post_id]
        @my_shelf_post = MyShelfPost.where(:post_id => @post_id).limit(1)[0]
        @my_shelf_post.destroy
        flash[:success] = "The post removed from your my shelf."
        redirect_to request.referer
    end

end
