class Api < ApplicationController
  @@API_SECRET = Apikey.first.secret
  @@API_KEY = Apikey.first.token

def stream
  
  @clients=Array.new
  @streams=Array.new
  @boars=Boar.where(:active=>true)
  @hunters=Hunter.where(:active=>true)
  shot_time=Shot.maximum(:created_at).to_i
  shot_time=shot_time*1000
  Hunter.where(:active=>true).each{|hunter| 
  client = LinkedIn::Client.new(@@API_KEY, @@API_SECRET)
  client.authorize_from_access(hunter.token, hunter.secret)
  @clients.push(client)}
  
  @clients.each {|client|
  client.network_updates(:type => 'CONN',:after => shot_time).updates.each {|update|
    if (update.profile.connections)
         update.profile.connections.each {|connection|
         if (connection.headline)
           @boars.each{|boar| 
           #check if boar is shot
           if (connection.headline.downcase.include? boar.title.downcase)
               comments=connection.headline.downcase.gsub(boar.title.downcase,"<span class='hilite'>" + boar.title.downcase+"</span>")
               Shot.create!(:connection_first=>update.profile.first_name + " " +update.profile.last_name, :connection_second=> connection.first_name + " " + connection.last_name, :comments=>comments, :headline=> connection.headline, :hunter=>client.profile.first_name, :source=>"stream", :important=>false, :boar=>boar.title, :boar_id=>boar.id)
           end
           }
         end
         }   
    end
    } 
  }
  
  end
  
end
