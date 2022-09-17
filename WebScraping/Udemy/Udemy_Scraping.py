from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.common.exceptions import NoSuchElementException
import xml.etree.ElementTree as gfg 
from fake_useragent import UserAgent


class Course:
   
   def  __init__(self, title, rating, raviewsString, hoursString,lecturesString,levelString):
        self.title = title 
        self.rating = rating
        if len(raviewsString) == 0:
            self.raviewsCount = 0
        else:         
            self.raviewsCount = raviewsString[1:-1]
                
        splittedHours = hoursString.split(" ")
        if splittedHours[2] == "hours" or splittedHours[2] == "hour":
            self.hours = splittedHours[0]
        else:
            self.hours = '0,'+str( int(int(splittedHours[0])/3*5))  
        self.lectures = lecturesString[:lecturesString.find(" ")]            
        self.level = levelString
            
ua = UserAgent()
courses = []
site_num = 1
site_address =r"https://www.udemy.com/courses/it-and-software/?lang=en&locale=en_US&p={}&persist_locale=&price=price-free&sort=popularity" 

while True:
    ua = UserAgent()
    userAgent = ua.random
    windows_id = userAgent.find("Windows NT")
    if windows_id >0:
        while float(userAgent[windows_id+11:windows_id+14]) < 7: 
            userAgent = ua.random
            windows_id = userAgent.find("Windows NT")
            if windows_id < 0:
                break
    options = webdriver.ChromeOptions()
    options.add_argument(f'user-agent={userAgent}')
    driver = webdriver.Chrome(executable_path=r"C:\Users\danie\Downloads\chromedriver.exe",chrome_options=options)
    driver.get(site_address.format(site_num))   
    site_num+=1
    time.sleep(5) # give time to browser to load the page
    

    course_ul = driver.find_elements(By.CSS_SELECTOR,".course-list--container--3zXPS")
    
    if len(course_ul) ==0:
        break;
    course_list = course_ul[0].find_elements(By.CSS_SELECTOR, ".popper--popper--2r2To")
    course_list_len = len(course_list)
    if course_list_len ==0:
        break;
    for course in course_list:
        
        secondTitleLen = len(course.find_element(By.TAG_NAME, "h3").find_element(By.TAG_NAME, "a")\
              .find_element(By.CSS_SELECTOR,".udlite-sr-only").text)
        title = course.find_element(By.TAG_NAME, "h3").find_element(By.TAG_NAME, "a").text
        title = title[:len(title)-secondTitleLen]
        try:
            rating = course.find_element(By.CSS_SELECTOR,".udlite-heading-sm.star-rating--rating-number--2o8YM").text        
        except NoSuchElementException:
            rating = ""
        try:
            raviewsString = course.find_element(By.CSS_SELECTOR,".udlite-text-xs.course-card--reviews-text--1yloi").text       
        except NoSuchElementException:
            raviewsString = ""       
            
        course_card_rows = course.find_element \
            (By.CSS_SELECTOR,".udlite-text-xs.course-card--row--29Y0w.course-card--course-meta-info--2jTzN") \
            .find_elements(By.CSS_SELECTOR,".course-card--row--29Y0w")
        hoursString = course_card_rows[0].text
        lecturesString = course_card_rows[1].text
        levelString = course_card_rows[2].text

        courses.append(Course(title, rating, raviewsString, hoursString,lecturesString,levelString))
    driver.quit()

root = gfg.Element('ROOT') 
coursesList = gfg.Element('COURSES') 
root.append(coursesList)
for course in courses:
    courseXML = gfg.Element('COURSE') 
    coursesList.append(courseXML)
    
    titleXML = gfg.Element('TITLE') 
    courseXML.append(titleXML)
    titleXML.text = course.title
    
    ratingXML = gfg.Element('RATING') 
    courseXML.append(ratingXML)
    ratingXML.text = course.rating
    
    raviewsCountXML = gfg.Element('RAVIEWS_COUNT') 
    courseXML.append(raviewsCountXML)
    raviewsCountXML.text = course.raviewsCount
    
    levelXML = gfg.Element('LEVEL') 
    courseXML.append(levelXML)
    levelXML.text = course.level
    
    lecturesXML = gfg.Element('LECTURES_COUNT') 
    courseXML.append(lecturesXML)
    lecturesXML.text = course.lectures
    
    hoursXML = gfg.Element('TOTAL_HOURS') 
    courseXML.append(hoursXML)
    hoursXML.text = course.hours
    

tree = gfg.ElementTree(root)
      
with open ("result_Udemy_Scraping.xml","wb") as file :
    tree.write(file)
    
    
