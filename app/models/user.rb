class User < ActiveRecord::Base
  devise :database_authenticatable

  def to_param
    key
  end

  before_save :ensure_key

  def ensure_key
    if key.blank?
      self.key = generate_key
    end
  end

  private

  def generate_key
    loop do
      key = Devise.friendly_token
      break key unless User.find_by(:key => key)
    end
  end
end
