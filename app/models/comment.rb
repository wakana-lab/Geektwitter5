class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, optional: true
  belongs_to :shop, optional: true

  # コメント内容のバリデーションを追加（空でないこと、最大文字数など）
  validates :content, presence: true, length: { maximum: 500 }
  # どちらか一方のIDがあることを確認するカスタムバリデーション (オプション)
  validate :either_tweet_or_shop_must_be_present

  private

  def either_tweet_or_shop_must_be_present
    # tweet_id も shop_id も両方nilの場合にエラーを追加
    unless tweet_id.present? || shop_id.present?
      errors.add(:base, "コメントはツイートまたはお店のどちらかに紐付けられている必要があります")
    end
    # 両方同時に存在することを許可しない場合（排他的なコメントとする場合）
    # if tweet_id.present? && shop_id.present?
    #   errors.add(:base, "コメントはツイートまたはお店のどちらか一方にのみ紐付けられます")
    # end
  end
end
