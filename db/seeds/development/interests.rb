interest_titles = %w{
  旅行
  映画
  音楽
  ファッション
  料理
  スポー
}

interest_titles.each do |t|
  Interest.create!(
      title: t
  )
end

