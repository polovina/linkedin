scheduler = Rufus::Scheduler.start_new
 

#scheduler.every(Task.where(:task=>"stream")[0][:frequency]) do
 scheduler.every("10m") do
 Shot.stream
 end
  
 
#scheduler.every(Task.where(:task=>"search")[0][:frequency]) do
 scheduler.every("1h") do
 Shot.search
 end
  

