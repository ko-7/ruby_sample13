class CollaborationsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:target_user_id])
    current_user.apply(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Collaboration.find(params[:id]).target_user
    current_user.unapply(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
