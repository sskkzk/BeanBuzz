class Public::HomesController < ApplicationController
  # before_action :authenticate_user!, if: :require_authentication?, except: [:about, :top]

  def top
  end

  def about
  end

  # private

  # def require_authentication?
  #   # without_authentication パラメータが true の場合、認証をスキップする
  #   params[:without_authentication] != true
  # end
end