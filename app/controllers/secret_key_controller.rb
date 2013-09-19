require 'securerandom'

class SecretKeyController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user.secret_key = SecretKey.create!(key: SecureRandom.hex(64)) if @user.secret_key.nil?
    @user.save
  end

  def reset
  end
end
