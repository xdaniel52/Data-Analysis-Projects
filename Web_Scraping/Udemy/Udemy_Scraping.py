from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.common.exceptions import NoSuchElementException
import xml.etree.ElementTree as gfg 
from fake_useragent import UserAgent


class Course:
   '''Container for information about one course'''
   def  __init__(self, title, rating, raviews_string, hours_string,lectures_string,level_string):
        self.title = title 
        self.rating = rating
        if len(raviews_string) == 0:
            self.raviews_count = 0
        else:         
            self.raviews_count = raviews_string[1:-1]
                
        splitted_hours = hours_string.split(" ")
        if splitted_hours[2] == "hours" or splitted_hours[2] == "hour":
            self.hours = splitted_hours[0]
        else:
            self.hours = '0,'+str( int(int(splitted_hours[0])/3*5))  
        self.lectures = lectures_string[:lectures_string.find(" ")]            
        self.level = level_string
            
ua = UserAgent()

path_to_driver = r'C:\Users\daniel\Downloads\msedgedriver.exe' 
#https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/

courses = []#list of courses

site_num = 1
site_url =r"https://www.udemy.com/courses/it-and-software/?lang=en&locale=en_US&p={}&persist_locale=&price=price-free&sort=popularity" 


while True:
    ua = UserAgent()
    user_agent = ua.random
    windows_id = user_agent.find("Windows NT")
    if windows_id >0:
        while float(user_agent[windows_id+11:windows_id+14]) < 7: 
            userAgent = ua.random
            windows_id = userAgent.find("Windows NT")
            if windows_id < 0: #checks to eliminate old windows version
                break
    options = webdriver.ChromeOptions()
    options.add_argument(f'user-agent={userAgent}')
    driver = webdriver.Chrome(executable_path=path_to_driver,chrome_options=options)
    driver.get(site_url.format(site_num))   
    site_num+=1
    time.sleep(5) # give time to browser to load the page and javascript to work
    

    course_ul = driver.find_elements(By.CSS_SELECTOR,".course-list--container--3zXPS")
    
    if len(course_ul) ==0:
        break;
    course_list = course_ul[0].find_elements(By.CSS_SELECTOR, ".popper--popper--2r2To")
    course_list_len = len(course_list)
    if course_list_len ==0:
        break;
    for course in course_list:
        
        second_title_len = len(course.find_element(By.TAG_NAME, "h3").find_element(By.TAG_NAME, "a")\
              .find_element(By.CSS_SELECTOR,".udlite-sr-only").text)
        title = course.find_element(By.TAG_NAME, "h3").find_element(By.TAG_NAME, "a").text
        title = title[:len(title)-second_title_len]
        try:
            rating = course.find_element(By.CSS_SELECTOR,".udlite-heading-sm.star-rating--rating-number--2o8YM").text        
        except NoSuchElementException:
            rating = ""
        try:
            raviews_string = course.find_element(By.CSS_SELECTOR,".udlite-text-xs.course-card--reviews-text--1yloi").text       
        except NoSuchElementException:
            raviews_string = ""       
            
        course_card_rows = course.find_element \
            (By.CSS_SELECTOR,".udlite-text-xs.course-card--row--29Y0w.course-card--course-meta-info--2jTzN") \
            .find_elements(By.CSS_SELECTOR,".course-card--row--29Y0w")
        hours_string = course_card_rows[0].text
        lectures_string = course_card_rows[1].text
        level_string = course_card_rows[2].text

        courses.append(Course(title, rating, raviews_string, hours_string,lectures_string,level_string))
    driver.quit()

#creating xml tree from collected information
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
    raviewsCountXML.text = course.raviews_count
    
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
 
#save list of courses to file      
with open ("result_Udemy_Scraping.xml","wb") as file :
    tree.write(file)
    