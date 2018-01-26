module Response 

  #find element via driver as Selenium, timeout in seconds
  def Response.find(driver, timeout, params = {})

    wait = Selenium::WebDriver::Wait.new(timeout: timeout) # seconds
    wait.until { driver.find_element(params).displayed? }
    element = driver.find_element(params)

  end
  
end
