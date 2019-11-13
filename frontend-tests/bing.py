from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

driver = webdriver.Chrome()
driver.get("http://www.bing.com")

sign_in = driver.find_element_by_css_selector('#id_l')
sign_in.click()
time.sleep(2)
sign_in = driver.find_element_by_css_selector('#id_s')
sign_in.click()
time.sleep(2)

email_input = driver.find_element_by_css_selector('#i0116')
email_input.send_keys('garrettwong@outlook.com')
email_input.send_keys(Keys.RETURN)
time.sleep(2)

password_input = driver.find_element_by_css_selector('#i0118')
password_input.send_keys('gYcq7ae12345')
password_input.send_keys(Keys.RETURN)
time.sleep(2)

elem = driver.find_element_by_css_selector('.b_searchbox')
elem.send_keys('trusted tenure')
elem.send_keys(Keys.RETURN)
time.sleep(5)

next_search = driver.find_element_by_css_selector('#sb_form_q')
next_search.clear()
next_search.send_keys('johnny quest')
next_search.send_keys(Keys.RETURN)
time.sleep(5)

driver.close()