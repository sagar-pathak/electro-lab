class MessagesController < ApplicationController
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

    def index
        @author = User.find(params[:author_id])
        @author_full_name = @author.first_name+" "+ @author.last_name
        @message = Message.new
        @all_messages = Message.where(:from_id=>current_user.id, :to_id=>@author.id)
            .or(Message.where(:from_id=>@author.id, :to_id=>current_user.id))
            .order('created_at asc')
        #render :json => @all_messages
        render :index
    end

    def allMessages
        #@outgoing_msg_users = Message.select('distinct to_id').where("from_id=#{current_user.id}").union(Message.select('distinct from_id as to_id').where("to_id=#{current_user.id}"))
        #@incoming_msg_users = Message.select('distinct from_id as to_id').where("to_id=#{current_user.id}")
        sql = "select distinct to_id from (Select to_id from messages where from_id=#{current_user.id} 
                union Select from_id as to_id from messages where to_id=#{current_user.id}) as x where to_id !=#{current_user.id}"
        @all_users = ActiveRecord::Base.connection.execute(sql)
        #@all_users = (Message.select('distinct from_id as to_id').where(:to_id=>current_user.id))
        #.or(Message.distinct(:to_id).where(:from_id=>current_user.id))
        #@all_users = @outgoing_msg_users + @incoming_msg_users
        
        #render :json => @all_users
        @users = User.all
        render :all
    end

    def sendMessage
        @author = User.find(params[:author_id])
        @newmessage = Message.new(params.require(:message).permit(:message))
        @newmessage.from_id = current_user.id
        @newmessage.to_id = @author.id
        if @newmessage.save
            #flash[:success] = "New post successfully created!"
            redirect_to messages_url(author_id: @author.id)
        else
            flash.now[:error] = @newmessage.errors.full_messages.join(", ")
            render :index
        end
    end
end
