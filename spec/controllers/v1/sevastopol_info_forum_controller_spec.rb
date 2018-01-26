require 'rails_helper'

RSpec.describe V1::SevastopolInfoForumController, type: :controller do


  describe 'GET #index' do
    
    it 'returns http success'  do
      #check success status
      get :index, params: { login: SevastopolInfoForum::LOGIN, password: SevastopolInfoForum::PASSWORD }
      expect(response).to have_http_status(:ok)
      expect(response.header['Content-Type']).to eq("json; charset=utf-8")
      #check success body
      parsed_body = JSON.parse(response.body)
      unread_messages_count = parsed_body['unread_messages_count']
      expect(unread_messages_count).to eq('0')  
    end

  end


end