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
       consumer = OAuth::Consumer.new(Apikey.token, Apikey.secret, Apikey.options)
       access_token = OAuth::AccessToken.new(consumer, hunter.token, hunter.secret)
       
       #JSON.parse(client.get("http://api.linkedin.com/v1/people-search:(people:(distance,public-profile-url,id,first-name,last-name,headline,three-current-positions:(company:(name))))?facet=network,F&start=0&count=25&current-company=TRUE&company-name=Altoros", 'x-li-format' => 'json').body)
       #get("http://api.linkedin.com/v1/people-search?facet=network,F&company-name=Altoros").body
# Pick some fields
       #fields = ['first-name', 'last-name', 'headline', 'industry', 'num-connections'].join(',')

# Make a request for JSON data
       #json_txt = access_token.get("/v1/people/~:(#{fields})", 'x-li-format' => 'json').body
       #profile = JSON.parse(json_txt)
       #puts "Profile data:"
       #puts JSON.pretty_generate(profile)
end



end
