class PostController < ApplicationController
  def roulette
    all_question_choices = [
      # 質問1の選択肢 (15個)
      ["色: 赤", "色: 青", "色: 緑", "色: 黄", "色: オレンジ", "色: 紫", "色: 黒", "色: 白", "色: ピンク", "色: 茶", "色: グレー", "色: 水色", "色: 金", "色: 銀", "色: 銅"],
      # 質問2の選択肢 (15個)
      ["場所: 北海道", "場所: 東京", "場所: 大阪", "場所: 福岡", "場所: 沖縄", "場所: 京都", "場所: 名古屋", "場所: 仙台", "場所: 横浜", "場所: 神戸", "場所: 広島", "場所: 札幌", "場所: 埼玉", "場所: 千葉", "場所: 奈良"],
      # 質問3の選択肢 (15個)
      ["食べ物: 寿司", "食べ物: ラーメン", "食べ物: カレー", "食べ物: パスタ", "食べ物: ハンバーグ", "食べ物: 焼き肉", "食べ物: 天ぷら", "食べ物: お好み焼き", "食べ物: たこ焼き", "食べ物: ピザ", "食べ物: 蕎麦", "食べ物: うどん", "食べ物: 刺身", "食べ物: 焼き鳥", "食べ物: 餃子"],
      # 質問4の選択肢 (15個)
      ["動物: 犬", "動物: 猫", "動物: 鳥", "動物: 魚", "動物: パンダ", "動物: 象", "動物: ライオン", "動物: 虎", "動物: キリン", "動物: シマウマ", "動物: うさぎ", "動物: リス", "動物: クマ", "動物: 狐", "動物: 狼"]
    ]

    @question_titles = [
      "今日のラッキーカラーは？",
      "次に行きたい場所は？",
      "今日の気分に合う食べ物は？",
      "癒される動物は？"
    ]

    # 4つの質問に対してそれぞれルーレットを回し、結果を格納する配列
    @results = []

    all_question_choices.each_with_index do |choices_for_question, i|
      # 各質問に対応する選択肢の配列からランダムに1つ選択
      selected_choice = choices_for_question.sample
      @results << { question_number: i + 1, 
      title: @question_titles[i],
      choice: selected_choice }
    end
  end
end
