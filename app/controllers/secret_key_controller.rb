require 'securerandom'

class SecretKeyController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user.secret_key = SecretKey.create!(key: SecureRandom.hex(32)) if @user.secret_key.nil?
    @user.save
  end

  def reset
    @user = User.find(params[:user_id])
    @user.secret_key.key = SecureRandom.hex(32)
    @user.secret_key.save
    redirect_to user_secret_key_path(user_id: params[:user_id])
  end
end
