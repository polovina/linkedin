class Boar < ActiveRecord::Base

def self.wound?(boar, shot)
#check if boar is shot. Company aliases are in the aliases field
   return (boar.title + " "+ (boar.aliases ? boar.aliases : "")).strip.downcase.gsub(/,.-=_'"/,"").include? shot.downcase.gsub(/,.-=_'"/,"")
 end

def self.hunt(hunter, boar)
#checks if boar is in hunters network
   company=boar.title
   consumer = OAuth::Consumer.new(Apikey.token, Apikey.secret, Apikey.options)
   client = OAuth::AccessToken.new(consumer, hunter.token, hunter.secret)
   raw_first_conn=client.get('http://api.linkedin.com/v1/people-search:(people:(public-profile-url,first-name,last-name,headline,three-current-positions:(company:(name))))?facet=network,F&start=0&count=25&current-company=TRUE&company-name=' + company, 'x-li-format' => 'json')
   raw_second_conn=client.get('http://api.linkedin.com/v1/people-search:(people:(public-profile-url,first-name,last-name,headline,three-current-positions:(company:(name))))?facet=network,S&start=0&count=25&current-company=TRUE&company-name=' + company, 'x-li-format' => 'json')
   
   mail_body=""
   if (raw_first_conn.header.code.include? "200") and (raw_second_conn.header.code.include? "200")
      
      connections = JSON.parse(raw_first_conn.body)["people"]["values"]
      if connections
         connections.each{|connection| 
                connection_first = connection["firstName"].to_s + " " + connection["lastName"].to_s
                headline = connection["headline"].to_s
                connection_first_url = connection["publicProfileUrl"].to_s
                Shot.create!(:connection_first=>connection_first, :connection_first_url=>connection_first_url, :connection_second=>"", :headline=> headline, :hunter=>hunter.name, :source=>"search", :important=>false, :boar=>boar.title, :boar_id=>boar.id, :hunter_id=>hunter.id)
                mail_body=mail_body+ connection_first + "(" + connection_first_url + ") is working at targeting company " + boar.title + "\n"
                }
      mail_body="In hunter " + hunter.name + " first level network\n" + mail_body
      end
   
   
   connections = JSON.parse(raw_second_conn.body)["people"]["values"]
      if connections
         connections.each{|connection| 
                connection_second = connection["firstName"].to_s + " " + connection["lastName"].to_s
                headline = connection["headline"].to_s
                connection_second_url = connection["publicProfileUrl"].to_s
                Shot.create!(:connection_second=>connection_second, :connection_second_url=>connection_second_url, :connection_first=>"", :headline=> headline, :hunter=>hunter.name, :source=>"search", :important=>false, :boar=>boar.title, :boar_id=>boar.id, :hunter_id=>hunter.id)
                 mail_body=mail_body + connection_second + "(" + connection_second_url + ") is working at targeting company " + boar.title + "\n"
                      }
      mail_body="In hunter " + hunter.name + " LinkedIn second level network\n" + mail_body
      end
  
   
   searched_by =  boar.searched_by.to_s+","+hunter.id.to_s
   boar.update_attributes!(:searched_by=>searched_by)
   UserMailer.shot_boar(Hunter.where(:id=>boar.hunter_id).first, mail_body).deliver unless mail_body.length < 10
  end
 end

end
