from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.common.exceptions import NoSuchElementException
import xml.etree.ElementTree as gfg 


class Course:
   '''Container for information about one course'''
   def  __init__(self, title, skills_string, rating, raviews_string, level):
        self.title = title 
        self.skills = skills_string[(skills_string.find(":")+2):].split(", ")
        self.rating = rating
        if len(raviews_string) == 0:
            self.raviews_count = 0
        else:         
            raviews_string = raviews_string[1:raviews_string.find(" ")]
            if not raviews_string[-1].isnumeric():
                tmp_dict = {"k":1000,"m":1000000}
                self.raviews_count = str(int(float(raviews_string[:-1].replace(',','.'))*tmp_dict[raviews_string[-1]]))
            else:
                self.raviews_count = str(raviews_string)              
        self.level = level[:level.find(" ")]
        

path_to_driver = r'C:\Users\daniel\Downloads\msedgedriver.exe' 
#https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/

driver = webdriver.Edge(executable_path = path_to_driver)

courses = [] #list of courses

site_url = r"https://www.coursera.org/search?query=free&index=prod_all_launched_products_term_optimization&skills=Python%20Programming"

#open url in browser
driver.get(site_url)
time.sleep(5) # give time to browser to load the page

while True:
    time.sleep(2) # give time to browser to load the page
    course_ul = driver.find_elements(By.CSS_SELECTOR,".cds-9.css-18msmec.cds-10")
    if len(course_ul) ==0:
        break;
    course_list = course_ul[0].find_elements(By.TAG_NAME, "li")
    course_list_len = len(course_list)
    if course_list_len ==0:
        break;
    for course in course_list:
        title = course.find_element(By.TAG_NAME, "h2").text
        skillsString = course.find_element(By.CSS_SELECTOR,".cds-113.css-5or6ht.cds-115").text       
        try:
            rating = course.find_element(By.CSS_SELECTOR,".cds-113.css-zl0kzj.cds-115").text
            
        except NoSuchElementException:
            rating = ""
        selectedElemenets = course.find_elements(By.CSS_SELECTOR,".cds-113.css-14d8ngk.cds-115")
        if len(selectedElemenets) > 2:        
            raviewsString = course.find_elements(By.CSS_SELECTOR,".cds-113.css-14d8ngk.cds-115")[1].text
        else:
            raviewsString = ""
  
        level = course.find_elements(By.CSS_SELECTOR,".cds-113.css-14d8ngk.cds-115")[-1].text
              
        courses.append(Course(title, skillsString, rating, raviewsString, level))
    footer = driver.find_element(By.CSS_SELECTOR,".pagination-controls-container")
    
    button = footer.find_elements(By.TAG_NAME, "button")[-1]
    if not button.is_enabled():
        break
    driver.execute_script("arguments[0].click();", button)


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
    
    skillsXML = gfg.Element('SKILLS') 
    courseXML.append(skillsXML)
    
    for skill in course.skills:
        skillXML = gfg.Element('SKILL') 
        skillsXML.append(skillXML)
        skillXML.text = skill

tree = gfg.ElementTree(root)

#save list of courses to file 
with open ("result_Coursera_Scraping.xml","wb") as file :
    tree.write(file)
