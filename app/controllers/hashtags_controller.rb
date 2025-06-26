class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by!(name: params[:id].downcase) # idではなくnameで検索
    @tweets = @hashtag.tweets.includes(:user).order(created_at: :desc) # 関連するツイートを取得
  end
end
