class Hunter < ActiveRecord::Base

def self.clients(hunters)
  clients=Hash.new
  hunters.each{|hunter| 
  client = LinkedIn::Client.new(Apikey.token, Apikey.secret)
  client.authorize_from_access(hunter.token, hunter.secret)
  clients[hunter.id]=client
  }
return clients
end

def self.shot_time(hunters)
  shot_time=Hash.new
  #retrieving specific timestamps for each hunter
  
  hunters.each{|hunter| shot_time[hunter.id]=(Shot.where(:hunter_id=>hunter.id.to_s).maximum(:created_at) ? Shot.where(:hunter_id=>hunter.id.to_s).maximum(:created_at).to_i*1000 : (Time.now- (60*24)).to_i*1000)}
return shot_time
end

end
