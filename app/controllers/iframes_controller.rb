class IframesController < ApplicationController
  layout false
  
  def index
    @vote = Vote.new(url: params[:url])
    # TODO 先にurl_hもセットすべき？
    @vote.set_url_h
    @vote_counts = Vote.where(url_h: @vote.url_h).group(:value).count
    cookies[:polls_uid] ||= generate_user_id
    @uid = cookies[:polls_uid]
  end
  
  def test
  end
  
  private
  def generate_user_id
    "#{Date.today.strftime('%Y%m%d')}#{Random.new.rand(100000..999999)}"
  end
end
