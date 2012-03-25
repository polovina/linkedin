class UploadController < ApplicationController
  
  def index
     #render :file => "/app/views/upload/index.html.haml"
     #render :text => "text"
  end
  
  def uploadFile
    post = Boar.upload(params[:upload])
    render :text => "File has been uploaded successfully"
  end
end
