class Vote < ApplicationRecord
  validates :group_id, presence: true
  validates :user_id, presence: true
  validates :value, presence: true
  validates :url, presence: true
  
  before_save :set_url_h
  
  def set_url_h
    self.url_h = Digest::MD5.hexdigest(url)[0..11]
  end
end
