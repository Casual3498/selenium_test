require 'rails_helper'


RSpec.describe SevastopolInfoForum::Navigation do
  let!(:navigation) { SevastopolInfoForum::Navigation.new(login: SevastopolInfoForum::LOGIN, password: SevastopolInfoForum::PASSWORD) }
  after { navigation.quit }

  describe '#login' do
    subject { navigation.logged_in?() }

    it 'logged_in false' do
      is_expected.to be false
    end 

    it 'valid login' do
      navigation.login
      is_expected.to be true
    end
  end

  describe '#unread_messages_count' do
    before { navigation.login } 
    subject { navigation.unread_messages_count }

    it 'unread_messages_count must be 0' do
      is_expected.to eq "0"
    end 
  end

end


