from pyselenium.test_metadata import Test
from pyselenium.test_steps import *
from pyselenium.test_runner import *
from selenium import webdriver
from selenium.webdriver.common.keys import Keys

test = Test('Bing test')
test.add_step(Navigate('http://www.bing.com'))

driver = webdriver.Chrome()
driver.get("http://www.bing.com")
driver.find_element_by_css_selector('#id_l').click()
test.add_step(TypeText(css_path='.b_searchbox', hint='Bing search bar', text='Google search'))
test.add_step(SendEnter())
test_runner = TestRunner(test)
test_result = test_runner.run_test()

print(test_result)
