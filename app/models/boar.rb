class Boar < ActiveRecord::Base

def self.wound?(boar, shot)
#check if boar is shot. Company aliases are in the aliases field
   return (boar.title + " "+ (boar.aliases ? boar.aliases : "")).strip.downcase.gsub(/,.-=_'"/,"").include? shot.downcase.gsub(/,.-=_'"/,"")
 end

end
