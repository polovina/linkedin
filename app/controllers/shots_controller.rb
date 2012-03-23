class ShotsController < ApplicationController
 
 def show
    # will render app/views/shots/show.<extension> by default
  end

 def index
  
   @page= params[:page] ? params[:page].to_i : 1
   @rows_on_page= params[:rows_on_page] ? params[:rows_on_page].to_i : 20
   @sort= params[:sort] ? params[:sort]: "created_at"
   @source= params[:source] ? params[:source] :  Shot.sources
   @pages=Shot.pages(@rows_on_page, @source)
   @last_activity=Shot.maximum(:created_at)
   #displaying one page at a time
   @shots = @source ? Shot.where(:source=>@source).order(@sort+ " DESC").limit(@rows_on_page).offset((@page-1)*@rows_on_page) : Shot.all
   
   #@shots=Shot.where(:source=>@source).order(@sort+ " DESC").limit(@rows_on_page).offset((@page-1)*@rows_on_page)
 end

  def edit
    @shot = Shot.find params[:id]
  end

  def update
    @shot = Shot.find params[:id]
    @shot.update_attributes!(params[:shot])
    flash[:notice] = "#{@shot.created_at} was successfully updated."
    redirect_to shots_path
  end

   def task_stream
    Shot.stream
    redirect_to shots_path
   end
   
   def task_search
    Shot.search
    redirect_to shots_path
   end

end
