class Apikey < ActiveRecord::Base

  def self.token
  #Apikey.select(:token).first.token
  token="crbvkpxjvxb3"
  return token
  end
  
  def self.secret
  #Apikey.select(:secret).first.secret
  secret="oP9l0V9qrwMdRD2X"
  return secret
  end

   def self.options
   # Set up LinkedIn specific OAuth API endpoints
   options = {:site => "https://api.linkedin.com",
              :authorize_path => "/uas/oauth/authorize",
              :request_token_path => "/uas/oauth/requestToken",
              :access_token_path => "/uas/oauth/accessToken" }
   end
   
   def self.host
   # Set up host for callbacks
   host= "hollow-sword-1707.herokuapp.com"
   #host= "localhost:3000"
   end
end



