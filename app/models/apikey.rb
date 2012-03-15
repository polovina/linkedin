class Apikey < ActiveRecord::Base

  def self.token
  Apikey.select(:token).first.token
  end
  def self.secret
  Apikey.select(:secret).first.secret
  end
end
