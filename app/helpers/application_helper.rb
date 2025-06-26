module ApplicationHelper
  def sanitize_with_hashtags(text)
    # 本文中のハッシュタグをリンクに変換する正規表現
    # 例: #hogehoge を <a href="/hashtags/hogehoge">#hogehoge</a> に変換
    text.gsub(/[#＃]([A-Za-z0-9_]+)/) do |match|
      name = match.delete('#').downcase
      hashtag = Hashtag.find_by(name: name)
      if hashtag
        link_to "##{name}", hashtag_path(hashtag), class: "hashtag-link" # 必要に応じてclassを追加
      else
        match # ハッシュタグが存在しない場合はそのまま表示
      end
    end.html_safe # HTMLとして安全な文字列としてマーク
  end
end
