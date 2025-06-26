class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :tweet_hashtags, dependent: :destroy
  has_many :hashtags, through: :tweet_hashtags
  has_one_attached :image
  
  #tweetsテーブルから中間テーブルに対する関連付け
  has_many :tweet_tag_relations, dependent: :destroy
  #tweetsテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :tweet_tag_relations, dependent: :destroy

private

  def save_hashtags
    # 本文からハッシュタグを抽出する正規表現
    # 例: #hogehoge の形式にマッチ
    extracted_hashtags = self.content.scan(/[#＃][A-Za-z0-9_]+/).map do |tag|
      tag.delete('#').downcase # # を削除し、小文字に変換
  end

    # 既存のハッシュタグを一旦クリア（更新時の重複保存防止）
  self.hashtags.clear if self.hashtags.present?

  extracted_hashtags.uniq.each do |tag_name|
    hashtag = Hashtag.find_or_create_by(name: tag_name)
    self.hashtags << hashtag unless self.hashtags.include?(hashtag)
  end
  end

end
