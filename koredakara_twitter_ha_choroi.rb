Plugin::create(:koredakara_twitter_ha_choroi) do
  on_boot do
    FAV_THRETHORLD = 5
    @favorited = Hash.new
  end
  on_favorite do|s, u, m|
    if !@favorited[m[:id]]
      @favorited[m[:id]] = {user: u, count: 1, tweeted: false}
    end
    count = @favorited[m[:id]][:count]
    tweeted = @favorited[m[:id]][:tweeted]
    @favorited[m[:id]] = {user: u, count: count+1, tweeted: tweeted}
    if count >= FAV_THRETHORLD && !tweeted
      @favorited[m[:id]][:tweeted] = true
      url = "http://favstar.fm/users/#{u}/status/#{m[:id]}"
      Post.primary_service.update(:message => "#koredakara_twitter_ha_choroi #{url}")
    end
  end
end
