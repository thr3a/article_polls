class IframesController < ApplicationController
  layout false
  
  def index
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
