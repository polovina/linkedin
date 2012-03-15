class Shot < ActiveRecord::Base
#pagination for displaying pages
 def self.pages(records_in_page, source)
   pages=Array.new
   (Shot.where(:source=>source).count/records_in_page).times {|i| pages.push(i+1)}
   return pages.drop(1)
 end
#creating array of all source filters
 def self.sources
   all_sources=Array.new
   Shot.select(:source).group(:source).each {|source| all_sources.push(source.source)}
   return all_sources
 end

#task for streaming LinkedIn activity
def self.stream
  hunters=Hunter.where(:active=>true)
  clients=Hunter.clients(hunters)
  shot_time=Hunter.shot_time(hunters)
  boars=Boar.where(:active=>true)
  hunters=Hunter.where(:active=>true)
  
  #looping all clients
  clients.each {|id, client|
  hunter= client.profile.first_name + " " +client.profile.last_name
  client.network_updates(:type => 'CONN',:after => shot_time[id]).updates.each {|update|
    connection_first=update.profile.first_name + " " +update.profile.last_name
      
      if (update.profile.connections)
         update.profile.connections.each {|connection|
         if (connection.headline)
           headline= connection.headline
           connection_second=connection.first_name + " " + connection.last_name
           comments="test"
           boars.each{|boar| 
           #check if boar is shot. Company aliases are in the aliases field
           search_string = (boar.title + " "+ (boar.aliases ? boar.aliases : "")).strip
           if (headline.downcase.gsub(/,.-=_'"/,"").scan(/\w+/) & search_string.downcase.scan(/\w+/)).empty?
          else
               #Addind shot table
               Shot.create!(:connection_first=>connection_first, :connection_second=> connection_second, :comments=>comments, :headline=>headline, :hunter=>hunter, :source=>"stream", :important=>false, :boar=>boar.title, :boar_id=>boar.id, :hunter_id=>id)
           end
           }
         end
         }   
      end
    } 
  }
 end

def self.search
  hunters=Hunter.where(:active=>true)
  clients=Hunter.clients(hunters)
  boars=Boar.where(:active=>true)
  clients.each {|id, client|
      hunter= client.profile.first_name + " " +client.profile.last_name
      boars.each {|boar|
        search_string = (boar.title + " "+ (boar.aliases ? boar.aliases : "")).strip
        total_profiles = client.search(:company=>boar.title, :current_company=>true, :network=>"in").total
        #to prevent Linkedin bouncing
        total_profiles = 100 unless total_profiles<100
           (total_profiles/20).times{|i| 
           #looping all boars
           client.search(:company=>boar.title, :network=>"in", :start=>(20*i), :count=>20).profiles.each{|profile|
           headline= profile.headline
           connection_second= profile.first_name + " " + profile.last_name
           if (headline.downcase.gsub(/,.-=_'"/,"").scan(/\w+/) & search_string.downcase.scan(/\w+/)).empty?
           else
           Shot.create!(:connection_first=>"undefined", :connection_second=>connection_second, :headline=> headline, :hunter=>hunter, :source=>"search", :important=>false, :boar=>boar.title, :boar_id=>boar.id, :hunter_id=>id)  unless (Shot.where(:connection_second=> connection_second, :headline=> headline, :hunter=>hunter, :boar=>boar.title).count)>0
            end
            }         
         }
       }
      }
 end
end