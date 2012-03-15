class StreamsController < ApplicationController
   @clients=Hash.new
   @streams=Array.new
   @boars=Boar.where(:active=>true)
   @hunters=Hunter.where(:active=>true)
   




#LinkedIn activity stream http_request
def stream
  Shot.stream
  redirect_to shots_path
  end
 
 #searching LinkedIn
 def search
  flash[:notice] = "Query executed" + Time.now.to_s
  @clients=Array.new
  @boars=Boar.where(:active=>true)
  
  Hunter.where(:active=>true).each{|hunter| 
  client = LinkedIn::Client.new(Apikey.first.token,Apikey.first.secret)
  client.authorize_from_access(hunter.token, hunter.secret)
  @clients.push(client)}
  #raise @clients.length.inspect
  @clients.each {|client|
  #raise client.profile(:fields=>['first-name','last-name', 'headline','public-profile-url','id']).public_profile_url.inspect
                   @boars.each {|boar|
                     i=1
                     total_profiles = client.search(:company=>boar.title, :current_company=>true, :network=>"in").total
                     #to prevent exceptions
                     total_profiles = 100 unless total_profiles<100
                     while i<=total_profiles
                     client.search(:company=>boar.title, :network=>"in", :start=>1, :count=>10).profiles.each{|profile|
                     Shot.create!(:connection_first=>"undefined", :connection_second=> profile.first_name + " " + profile.last_name, :headline=> profile.headline, :hunter=>client.profile.first_name, :source=>"search", :important=>false, :boar=>boar.title, :boar_id=>boar.id)}
                     i=i+20
                     end
                     }
                 }
 flash[:notice] = "Query executed" + Time.now.to_s
 redirect_to shots_path
 #render :nothing => true
 end

#LinkedIn activity stream automate task
  
  
end  
