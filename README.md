# Installation Notes
To run the script on Windows, following are needed to be installed:
- Python
- Robotframework
- Robotframework SeleniumLibrary
- Selenium Webdriver

**Install Python and PIP**
1. Download installer for Python 3.9.2 (Windows), go to https://www.python.org/ftp/python/3.9.2/python-3.9.2-amd64.exe
2. Run python installer as Administrator
3. Check "Add Python 3.9 to PATH"
4. Click "Install Now"
5. Open command prompt as Administrator, navigate to the installation path and check python is installed
   
   ```
   python --version
   ```

**Install Robot Framework and SeleniumLibrary**
1. Open command prompt as Administrator and install Robotframework
    
    ```
    pip install robotframework
    ```

2. Then install SeleniumLibrary
    
    ```
    pip install robotframework-seleniumlibrary
    ```
    
3. Verify installation by running the command:
    
    ```
    pip list
    ```

**Install Selenium Webdriver**

This script will run on Chrome so ChromeDriver should be downloaded.

1. Create **C:/bin** folder.
2. Add **C:/bin** to PATH.
3. Download ChromeDriver for Windows, go to https://chromedriver.storage.googleapis.com/89.0.4389.23/chromedriver_win32.zip
4. Extract zip file and copy <i>chromedriver.exe</i> to **C:/bin**

# Run Test Script

1. Download the rf-shop-the-look, https://github.com/jocelangkico/rf-shop-the-look
2. Extract the zip file   
2. Open command prompt and navigate to the folder path (e.g. C:/Users/<username>/Downloads)
3. Run the command:
   ```
   robot -d results rf-shop-the-look-master/tests/AddProductToWishlist.robot
   ```
This will run the test automation script. Chrome browser will be opened then steps will be executed.
   
4. To view the test result, go the **rf-shop-the-look-master/Results** folder and open <i>report.html</>
