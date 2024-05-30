from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import time

# Define the Selenium Grid URL
grid_url = "http://172.22.0.9:4444/wd/hub"

# Define browser configurations
browser_configs = [
    {"browserName": "chrome", "success_message": "Chrome test successful!"},
    {"browserName": "MicrosoftEdge", "success_message": "Edge test successful!"},
    {"browserName": "firefox", "success_message": "Firefox test successful!"}
]

# Define the URL of the website you want to test
website_url = "https://production.adcuratio.net"

# Define function to run test with a browser
def run_test(browser_config):
    # Initialize browser options
    options = webdriver.ChromeOptions() if browser_config["browserName"] == "chrome" else webdriver.FirefoxOptions()

    # Start a WebDriver session with the specified browser
    driver = webdriver.Remote(command_executor=grid_url, options=options)

    try:
        # Open the website
        driver.get(website_url)

        # Wait for a few seconds to observe
        time.sleep(5)

        # Print the page title
        print(f"{browser_config['browserName'].capitalize()} - Page title:", driver.title)

        # Print success message
        print(browser_config["success_message"])

    finally:
        # Quit the WebDriver session
        driver.quit()

# Run tests for each browser configuration
for config in browser_configs:
    run_test(config)
