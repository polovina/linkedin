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
  hunters.each{|hunter| 
  Shot.where(:hunter_id=>hunter.id.to_s).maximum(:created_at)
  shot_time[hunter.id]=(Shot.where(:hunter_id=>hunter.id.to_s).maximum(:created_at) ? Shot.where(:hunter_id=>hunter.id.to_s).maximum(:created_at).to_i*1000 : (Time.now- (60*24)).to_i*1000)}
return shot_time
end

def self.connection_check(token, name)
    connections = Array.new()
    #hunter=Hunter.where(:email=>email).first
    client = LinkedIn::Client.new(Apikey.token, Apikey.secret)
    client.authorize_from_access(token, Hunter.where(:token=>token).first.secret)
    client.connections(:fields=>(["first-name", "last-name"])).each{|connection| connections.push((connection.first_name + connection.last_name).downcase)}
    return connections.select{|element| element==name}
end

def self.test
       
       hunter = Hunter.where(:email=>"alex.polovinko@gmail.com").first
# Set up LinkedIn specific OAuth API endpoints
       consumer_options = {:site => "https://api.linkedin.com",
                     :authorize_path => "/uas/oauth/authorize",
                     :request_token_path => "/uas/oauth/requestToken",
                     :access_token_path => "/uas/oauth/accessToken" }
       
       consumer = OAuth::Consumer.new(Apikey.token, Apikey.secret, consumer_options)
       access_token = OAuth::AccessToken.new(consumer, hunter.token, hunter.secret)
       #get("http://api.linkedin.com/v1/people-search?facets=network&facet=network,F&company-name=Altoros")
# Pick some fields
       #fields = ['first-name', 'last-name', 'headline', 'industry', 'num-connections'].join(',')

# Make a request for JSON data
       #json_txt = access_token.get("/v1/people/~:(#{fields})", 'x-li-format' => 'json').body
       #profile = JSON.parse(json_txt)
       #puts "Profile data:"
       #puts JSON.pretty_generate(profile)
end



end
