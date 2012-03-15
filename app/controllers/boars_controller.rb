class BoarsController < ApplicationController

  def show
    id = params[:id] # retrieve company ID from URI route
    @boar = Boar.find(id) # look up company by unique ID
  # will render app/views/movies/show.<extension> by default
  end

 def index
  @boars=Boar.all
  @hunters=Hunter.all
  end


  def new
    # default: render 'new' template
  end

  def create
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

end