class HuntersController < ApplicationController
 

 def index
     @source="hunter"
     @hunters=Hunter.all
     @result = params[:result]
 end
 
 def edit
    @hunter = Hunter.find params[:id]
  end

  def update
    @hunter = Hunter.find params[:id]
    @hunter.update_attributes!(params[:hunter])
    flash[:notice] = "#{@hunter.name} was successfully updated."
    redirect_to hunters_path
  end
def check
    token = params[:token]
    name = (params[:fname]+params[:lname]).downcase
    @result = Hunter.connection_check(token, name)
    raise @result.inspect
    #render :text => "true"
    redirect_to hunters_path(:result=> @result)
  end
 
 def toggle
    @hunter = Hunter.find params[:id]
    @hunter.active ? @hunter.update_attribute(:active, false) : @hunter.update_attribute(:active, true)
    redirect_to hunters_path
 end
  
 def check
    token = params[:token]
    name = params[:name]
    #raise @result.inspect
    if token and name
    render :text=> Hunter.connection_check(token, name)
    else
    render :text=>"false1"
    end
    #raise token.inspect
    #render :text => "true"
    #redirect_to hunters_path
  end
 
 
 
  def destroy
    @hunter = Hunter.find(params[:id])
    @hunter.destroy
    flash[:notice] = "The hero '#{@hunter.name}' is tired and go to rest"
    redirect_to hunters_path
  end

 

end
