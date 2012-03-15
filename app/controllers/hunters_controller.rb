class HuntersController < ApplicationController
 @@API_KEY=Apikey.first.token
 @@API_SECRET=Apikey.first.secret
 
 

 def show
  client = LinkedIn::Client.new(Apikey.first.token, Apikey.first.secret)  
  if params[:pin].to_s=~/\d{5}/
     access=client.authorize_from_request(params[:rtoken],params[:rsecret], params[:pin])
     client.authorize_from_access(access[0], access[1])
     profile=client.profile(:fields=>['first-name','last-name', 'headline','picture-url','id'])
     if profile
     Hunter.create!(:name => profile.first_name, :token=>access[0], :secret=>access[1], :image_url=>profile.picture_url, :linked_id=>profile.id, :active=>true)
     flash[:notice] = "#{profile.first_name} was successfully added"
     redirect_to boars_path
     else
     flash[:notice] = "Could not auhtorise, one more time"
     redirect_to "/hunters/new"
     end
  else
  flash[:notice] = "Token should be 5 digits"
  redirect_to "/hunters/new"
  end
  
  end
  
  def new
   
    client = LinkedIn::Client.new(@@API_KEY, @@API_SECRET)
    @rtoken = client.request_token.token
    @rsecret = client.request_token.secret
    @url=client.request_token.authorize_url
    
  end


  def toggle
    @hunter = Hunter.find params[:id]
    @hunter.active ? @hunter.update_attribute(:active, false) : @hunter.update_attribute(:active, true)
    redirect_to boars_path
  end
  
  def destroy
    @hunter = Hunter.find(params[:id])
    @hunter.destroy
    flash[:notice] = "The hero '#{@hunter.name}' is tied and go to rest"
    redirect_to boars_path
  end

end
