class V1::SevastopolInfoForumController < ApplicationController

  def index
    begin
      #create Navigation class instance
      navigation = SevastopolInfoForum::Navigation.new(login: params[:login], password: params[:password]) 

      #Login to forum
      navigation.login
      
      #get data from forum
      json_api_data = { unread_messages_count: navigation.unread_messages_count }
    #if error is occured
    rescue RuntimeError => detail
      json_api_data = { error: "RuntimeError is occured: #{detail}" }       
    ensure
      #close browser
      navigation.quit if navigation
    end
    #return data
    render json: json_api_data, status: :ok, content_type: :json
  end

end
