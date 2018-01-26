require_relative 'response'

module SevastopolInfoForum
  # HREF = 'https://forum.sevastopol.info'
  HREF_LOGIN = 'https://forum.sevastopol.info/ucp.php?mode=login'
  HREF_INBOX = 'https://forum.sevastopol.info/ucp.php?i=pm&folder=inbox'
  LOGIN = ENV['SevastopolInfoForum_LOGIN']
  PASSWORD = ENV['SevastopolInfoForum_PASSWORD']


  class Navigation 
  include Response

    def initialize (login:, password:)
      @login = login
      @password = password
      @logged_in = false
      #increase timeout to prevent Net::ReadTimeout error
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 180 # seconds
      @driver = Selenium::WebDriver.for :firefox, http_client: client     
    end

    def login
      # go to login page
      @driver.navigate.to HREF_LOGIN

      # fill username
      element = Response::find(@driver, 300, name: 'username')
      element.send_keys @login

      # fill password
      element = Response::find(@driver, 120, name: 'password')
      element.send_keys @password
      
      # click login button
      element = Response::find(@driver, 120, name: 'login', class: 'btnmain')    
      element.click

      # check that login successful if 'Выход' text exists
      element = Response::find(@driver, 120, id: 'menubar')
      @logged_in = (/Выход/ === element.text)
      # exception if not logged in
      raise 'NotLoggedIn' unless @logged_in
      return @logged_in
    end

    def unread_messages_count
      #go to inbox
      @driver.navigate.to HREF_INBOX

      #find element contains message count
      element = Response::find(@driver, 120, id: 'wrapcentre')
      
      #parse element.text to extract message count
      match_data = element.text.match(/\[\s(\d*)\/300\sСообщения(.*)\]/)
      
      #raise exception if unread_message_count not found
      raise 'NotFound' unless match_data
      
      #get unread_message_count 
      unread_message_count = match_data[1]
    end

    def logged_in?
      @logged_in
    end

    def quit
      @logged_in = false
      @driver.quit
    end


  end

end