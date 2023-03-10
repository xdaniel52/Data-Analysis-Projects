from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.common.exceptions import NoSuchElementException
import xml.etree.ElementTree as gfg 
from fake_useragent import UserAgent


class Studies:
   '''contains information about the entire studies history'''
   def  __init__(self): 
        self.semesters = []
        
class Semester:
   '''contains information about the entire semester'''
   def  __init__(self, name, id):
        self.name = name 
        self.id = id 
        self.grades = []
        
class Grade:
   '''contains information about one grade'''
   def  __init__(self, subject, grade, grade_WYK, grade_CW, grade_LAB):
        self.subject = subject 
        self.grade = grade
        self.grade_WYK = grade_WYK
        self.grade_CW = grade_CW
        self.grade_LAB = grade_LAB
        
            
path_to_driver = r'C:\Users\daniel\Downloads\msedgedriver.exe' 
#https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/

courses = []
site_num = 1
#university site with stidies info
site_address =r"https://logowanie.pcz.pl/cas/login?service=https%3A%2F%2Fusosweb.pcz.pl%2Fkontroler.php%3F_action%3Dlogowaniecas%2Findex&locale=pl"
 
#user data
user_email = "fill@yourmail.here"
user_password = "*****************"

ua = UserAgent()
user_agent = ua.random

windows_id = user_agent.find("Windows NT")
if windows_id >0:
    while float(user_agent[windows_id+11:windows_id+14]) < 7: 
        userAgent = ua.random
        windows_id = userAgent.find("Windows NT")
        if windows_id < 0:#checks to eliminate old windows version
            break
        
options = webdriver.ChromeOptions()
options.add_argument(f'user-agent={userAgent}')
driver = webdriver.Chrome(executable_path=path_to_driver,chrome_options=options)
driver.get(site_address)   

time.sleep(0.1) # give time to browser to load the page

#sign in
username = driver.find_element(By.ID,"username")
username.send_keys(user_email);
password = driver.find_element(By.ID,"password")
password.send_keys(user_password);
button = driver.find_elements(By.TAG_NAME, "button")[0]
driver.execute_script("arguments[0].click();", button)

#click "dla studentow" label
dla_studentow_label = driver.find_element(By.CLASS_NAME,"menu")\
                .find_elements(By.CSS_SELECTOR,"a")[3]                  
driver.execute_script("arguments[0].click();", dla_studentow_label)
time.sleep(0.5)

#click "oceny" label
oceny_label = driver.find_elements(By.CSS_SELECTOR,".item.level2")[6]\
                .find_element(By.CSS_SELECTOR,"a")
driver.execute_script("arguments[0].click();", oceny_label)

#select semesters
tbodys = driver.find_elements(By.CSS_SELECTOR,".grey")[0]\
                .find_elements(By.TAG_NAME,"tbody")


stu = Studies()
for i in range(0,len(tbodys),2):
    
    sem_name = tbodys[i].find_element(By.TAG_NAME,"td").text
    sem_name = sem_name[:sem_name.find("-")]
    sem = Semester(sem_name, (len(tbodys) - i)//2)
    stu.semesters.append(sem)
    
    subjects = tbodys[i+1].find_elements(By.TAG_NAME,"tr")    
    for sub in subjects:
        sub_name = sub.find_elements(By.TAG_NAME,"td")[0]\
                        .find_element(By.TAG_NAME,"a").text
        grade=None
        wyk=None
        cw=None
        lab=None
        divs = sub.find_elements(By.TAG_NAME,"td")[2]\
                        .find_elements(By.TAG_NAME,"div")
        for div in divs:
            try:
                typee, mark= div.text.split(": ")
            except:
                break
            if typee == "Ocena":
                grade = mark
            elif typee == "WYK":
                wyk = mark
            elif typee == "CW":
                cw = mark
            elif typee == "LAB":
                lab = mark
               
        sem.grades.append(Grade(sub_name,grade,wyk,cw,lab))         
        

driver.quit()

#creating xml tree from collected information
root = gfg.Element('ROOT') 
semestersList = gfg.Element('SEMESTERS') 
root.append(semestersList)
for semester in stu.semesters:
    semesterXML = gfg.Element('SEMESTER') 
    semestersList.append(semesterXML)
    semesterXML.set('number', str(semester.id))
    semesterXML.set('name', semester.name)
    subjectsXML = gfg.Element('SUBJECTS') 
    semesterXML.append(subjectsXML)
    for sub in semester.grades:
        subjectXML = gfg.Element('SUBJECT') 
        semesterXML.append(subjectXML)
        
        nameXML = gfg.Element('NAME')     
        subjectXML.append(nameXML)
        nameXML.text = sub.subject
        
        grade1XML = gfg.Element('FINAL_GRADE') 
        grade1XML.text = str(sub.grade)
        subjectXML.append(grade1XML)
        
        grade2XML = gfg.Element('LECTURE_GRADE') 
        grade2XML.text = str(sub.grade_WYK)
        subjectXML.append(grade2XML)
        
        grade3XML = gfg.Element('EXERCISES_GRADE') 
        grade3XML.text = str(sub.grade_CW)
        subjectXML.append(grade3XML)
        
        grade4XML = gfg.Element('LAB_GRADE') 
        grade4XML.text = str(sub.grade_LAB)
        subjectXML.append(grade4XML)
        
    
tree = gfg.ElementTree(root)
    
#save list of courses to file  
with open ("grades_from_usos.xml","wb") as file :
    tree.write(file)
    