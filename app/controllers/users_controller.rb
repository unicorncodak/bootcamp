class UsersController < ApplicationController
    before_action :is_admin, only: [:admin]
    def index
        @users = User.all
    end

    def new
    end

    def admin
        @users = User.all
        @projects = Project.all
    end

    def profile
        @user = User.find(session[:user_id])
    end

    
    def create
        @users = User.new(user_params)
        if @users.save
            session[:user_id] = @users.id
            redirect_to projects_path
        else
            redirect_to new_user_path
            flash[:errors] = @users.errors.full_messages
        end
    end

    # GET /projects/1/edit
    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        respond_to do |format|
            if @user.update(user_update_params)
              return redirect_to profile_users_path
              format.html { redirect_to @user, notice: 'Project was successfully updated.' }
              format.json { render :show, status: :ok, location: @user }
            else
              format.html { render :edit }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
    end

    def show
        @user = User.find(params[:id])
    end

    def delete
        @user = User.find(params[:id])
        if @user.destroy
            redirect_to users_path
        end
    end

    def role
        @user = User.find(params[:id])
        if @user.admin_access > 0
            @user.update_column(:admin_access, 0);
            @user.save
            redirect_to admin_users_path
        elsif
            @user.update_column(:admin_access, 1);
            @user.save
            redirect_to admin_users_path
        end
    end

    private
        def user_params
            params.require(:user).permit(:username, :password, :email)
        end
    private
        def user_update_params
            params.require(:user).permit(:username, :email)
        end
        def is_admin
            user = User.find(session[:user_id])
            unless user.admin_access == 1
              redirect_back fallback_location: root_path
            end
        end
        
end
