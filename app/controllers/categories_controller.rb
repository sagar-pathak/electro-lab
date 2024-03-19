class CategoriesController < ApplicationController
    
    before_action :authenticate_admin!, only: [:list, :new, :update] 

    layout "admin_layout"
    
    def list
        @posts = Post.where(:isFlagged => false)
        @categories = Category.all
        render :list
    end

    def new
        @category = Category.new
        render :new
    end

    def create
        @category = Category.new(params.require(:category).permit(:name))

        if @category.save
            flash[:success] = "New category successfully added !"
            redirect_to categories_url
        else
            flash.now[:error] = "Failed to create category."
            render :new
        end
    end

    def edit
        @category = Category.find(params[:id])
        render :edit
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(params.require(:category).permit(:name))
            flash[:success] = "Category name successfully updated !"
            redirect_to categories_url
        else
            flash.now[:error] = "Failed to update Category"
            render :edit

        end
    end

    def authenticate_admin!
        unless user_signed_in? && current_user.admin?
            flash.alert = "Sorry, you don't have permissions to perform this action."
            redirect_to landingPage_url
        end
    end


end
