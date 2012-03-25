class BoarsController < ApplicationController
  require 'csv'
  
  def show
    id = params[:id] # retrieve company ID from URI route
    @boar = Boar.find(id) # look up company by unique ID
  # will render app/views/movies/show.<extension> by default
  end

 def index
  @hunters= Hash.new
  @source="boar"
  Hunter.all.each{|hunter| @hunters[hunter.id] = hunter.name}
  #raise @hunters.inspect
  @sort= params[:sort] ? params[:sort]: "created_at"
  @boars=Boar.order(@sort + " ASC")
  end


  def new
    # default: render 'new' template
   @hunter_names = Hash.new
   Hunter.all.each{|hunter| @hunter_names[hunter.id] = hunter.name}
   @hunters = Hunter.select([:id, :name])
  end

  def create
    #raise params[:boar].inspect
    @boar = Boar.create!(params[:boar])
    flash[:notice] = "#{@boar.title} was added"
    redirect_to boars_path
  end

  def edit
    @boar = Boar.find params[:id]
  end

  def update
    @boar = Boar.find params[:id]
    @boar.update_attributes!(params[:boar])
    flash[:notice] = "#{@boar.title} was successfully updated."
    redirect_to boars_path
  end

  def destroy
    @boar = Boar.find(params[:id])
    @boar.destroy
    flash[:notice] = "Boar '#{@boar.title}' was dismissed."
    redirect_to boars_path
  end

  def toggle
    @boar = Boar.find params[:id]
    @boar.active ? @boar.update_attribute(:active, false) : @boar.update_attribute(:active, true)
    redirect_to boars_path
  end

  def csv_import
    file = params[:file]
    #raise file.inspect
    CSV.new(file.tempfile, :headers => true).each do |row|
        Boar.create!(:title => row[0],
                      :category => row[1],
                      :crunchbase_url => row[2],
                      :seed_date => row[3],
                      :A_date => row[4],
                      :B_date => row[5],
                      :C_date => row[6],
                      :un_date=> row[7],
                      :employees=> row[8],
                      :fund => row[9],
                      :ceo => row[10],
                      :cto => row[11],
                      :founder => row[12],
                      :overview => row[13],
                      :hunter_id => params[:hunter]
                      )
    end
  redirect_to boars_path
  end


end
