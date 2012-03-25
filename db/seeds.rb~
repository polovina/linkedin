# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

InitialHunters = [
    {:id => '1', :name => 'Alexander', :token => '7a223b93-d600-453c-b604-b857914d08ec', :secret => '1f8a0de8-7040-4ac6-8b3c-32cae7fa3844', :linked_id => "111", :active =>true, :image_url=> "http://media.linkedin.com/mpr/mprx/0_LQ5WcDgG3XZUMY0lFCL9cmpiTCy9UZ0lbXl9cm0pYbe6kpHAW8v5Maw-72pd4xOgX5bB4dTuGxkK"},
    {:id => '2', :name => 'Vlad', :token => '9a61643c-1442-4944-8562-6dcfb571f7c2', :secret => 'efd8d20c-e75d-40b0-8146-ba05f13b0d24', :linked_id => "111", :active =>true, :image_url=> "http://media.linkedin.com/mpr/mprx/0_tpExEqAWs28xm8Zet0M8EBKe4SFxuLJerRYhEBi4FI17PTaHOVsPXcB998b8fG4kP0eT5rgM31tz"},
    {:id => '3', :name => 'Michael', :token => '98300d10-2f0e-49ed-8946-a3029b042657', :secret => '5fe6a11f-00b7-4d83-8a86-72372da9ebc6', :linked_id => "111", :active=>true, :image_url=> "http://media.linkedin.com/mpr/mprx/0_uQ-VaJ4tuplQvOqE25K5asep2yX6BgvEmG65asJ81Vr9eJCoh8G98VSmGlkJqsNQS5rX3jFuZp8I"}
  ]
  
InitialBoars = [
    {:title => 'Test', :rating => '10', :status => 'Novice', :description => "test", :active =>true, :source=> "initial seeding while development", :aliases =>"test"}]
  
InitialBoars.each {|boar|Boar.create!(boar)}
#InitialHunters.each { |hunter|Hunter.create!(hunter)}

#Apikey.create!(:token=>"pqj3j0pxa419",:secret=>"E79ZO9noc2wtJFzs")

Apikey.create!(:token=>"crbvkpxjvxb3",:secret=>"oP9l0V9qrwMdRD2X")
#Task.create!(:task=>"stream",:frequency=>"1m", :active=>true, :description=>"Parsing updates streams")
#Task.create!(:task=>"search",:frequency=>"10m", :active=>true, :description=>"Searching in network updates")

#Shot.create!(:connection_first=>"Initial first connection", :connection_second=> "Initial second connection", :comments=>"Initial comments", :headline=>"Initial headline", :hunter=>"Test hunter", :source=>"stream", :important=>false, :boar=>"Test boar", :boar_id=>"1", :hunter_id=>"1")

  
