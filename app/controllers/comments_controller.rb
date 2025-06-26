class CommentsController < ApplicationController
before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = parent.comments.build(comment_params) # 親（TweetまたはShop）にコメントを紐付ける
    comment.user_id = current_user.id
    
    if params[:tweet_id].present?
      parent = Tweet.find(params[:tweet_id])
    elsif params[:shop_id].present?
      parent = Shop.find(params[:shop_id])
    else
      # どちらの親も指定されていない場合はエラー
      flash[:alert] = "コメント対象が指定されていません。"
      redirect_back(fallback_location: root_path)
      return
    end
    
    if comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path) #直前のページにリダイレクト
    end
    
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
