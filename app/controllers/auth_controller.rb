class AuthController < ApplicationController

  def index
    # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new(Apikey.first.token, Apikey.first.secret)  
    request_host_with_port = "hollow-sword-1707.herokuapp.com:3000"
    request_token = client.request_token(:oauth_callback =>"http://#{request_host_with_port}/auth/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    redirect_to client.request_token.authorize_url

  end

  def callback
      client = LinkedIn::Client.new(Apikey.first.token, Apikey.first.secret)
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
     else
      client.authorize_from_access(session[:atoken], session[:asecret])
      atoken = session[:atoken]
      asecret = session[:asecret]
    end
     profile=client.profile(:fields=>['first-name','last-name', 'headline','picture-url','id'])
     
     if profile
     Hunter.create!(:name => profile.first_name, :token=>atoken, :secret=>asecret, :image_url=>profile.picture_url, :linked_id=>profile.id, :active=>true, :email=>params[:email], :password=>params[:password])
     flash[:notice] = "#{profile.first_name} was successfully added"
     else
     flash[:notice] = "Could not auhtorise, one more time"
     end
     redirect_to hunters_path 
  end
  
  def outlook
      if Hunter.where(:email => params[:email]).exists?
      render :xml=> Hunter.select(:token).where(:email => params[:email]) 
      else 
      render :text=> "user not registered"
      end
  end
    
   def check
    if params[:token] and params[:name]
       if Hunter.where(:token=> params[:token]).exists?
       render :xml=> Hunter.connection_check(params[:token], params[:name])
       else
       render :text=>"invalid token"
       end
    else
    render :text=>"invalid request"
    end
   end  

end

