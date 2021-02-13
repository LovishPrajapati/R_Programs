library(dbplyr)
library(RSQLite)
library(DBI)

con<-dbConnect(RSQLite::SQLite(),"University.sqlite")

Student<-data.frame(stuId=factor(c("S1001","S1002","S1005","S1010","S1013","S1015","S1020")) ,
                     lastName=c("Smith","Chin","Lee","Burns","McCarthy","Jones","Rivera"), 
                    firstName=c("Tom","Ann","Perry","Edward","Owen","Mary","Jane"), 
                    major=factor(c("History","Math","History","Art","Math","Math","CSC")), 
                     credits=c(90,36,3,63,0,42,15), 
                     stringsAsFactors = FALSE)


Faculty<-data.frame(facId=factor(c("F101","F105","F110","F115","F221")) ,
                    name=c("Adams","Tanaka","Byrne","Smith","Smith"), 
                    department=factor(c("Art","CSC","Math","History","CSC")), 
                    rank=factor(c("Professor","Instructor","Assistant","Associate","Professor")), 
                    stringsAsFactors = FALSE)

Class<-data.frame(classNumber=factor(c("ART103A","CSC201A","CSC203A","HST205A","MTH101B","MTH103C")),
                  facId=factor(c("F101","F105","F105","F115","F110","F110")), 
                    schedule=c("MWF9","TuThF10","MThF12","MWF11","MtuTh9","MWF11"), 
                    room=factor(c("H221","M110","M110","H221","H225","H225")), 
                    stringsAsFactors = FALSE);

Enroll<-data.frame(stuId=factor(c("S1001","S1001","S1002","S1002","S1002","S1010","S1010","S1020","S1020")),
                   classNumber=factor(c("ART103A","HST205A","ART103A","CSC201A","MTH103C","ART103A","MTH103C","CSC201A","MTH101B")), 
                  grade=factor(c("A","C","D","F","B","","","B","A")),
                  stringsAsFactors = FALSE);

dbWriteTable(con,"Student",Student)
dbWriteTable(con,"Faculty",Faculty)
dbWriteTable(con,"Class",Class)
dbWriteTable(con,"Enroll",Enroll)
#---------------------------------------------------------------------------------------------
# Get all information about “CSC” deptt.
res<-dbSendQuery(con,"SELECT * 
                 FROM Faculty 
                 WHERE department='CSC'")
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Get the course/class number  of all courses in which students are enrolled. 
res<-dbSendQuery(con,"SELECT DISTINCT classNumber 
                 FROM Enroll")
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Get names and IDs of all Faculty members, arranged in alphabetical order by name. Call the resulting columns FacultyName and FacultyNumber.

res<-dbSendQuery(con,"SELECT name as 'FacultyName',facId as 'FacultyId' 
                 FROM Faculty 
                 ORDER BY name")
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Get names of all math majors who have more than 30credits.

res<-dbSendQuery(con,"SELECT firstName,lastName 
                 FROM Student 
                 WHERE major=='Math' 
                 AND credits > 30")
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Find IDs and names of all students taking ART103A.

res<-dbSendQuery(con,"SELECT Student.stuId,Student.firstName,Student.lastName 
                 FROM Student 
                 INNER JOIN Enroll 
                 ON Student.stuId == Enroll.stuId 
                 AND Enroll.classNumber=='ART103A'")
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Find stuId and grade of all students taking any course taught by the Faculty member whose facId is F110. Arrange in order by stuId.

res<-dbSendQuery(con,"SELECT Enroll.stuId,Enroll.grade 
                 FROM Enroll 
                 INNER JOIN Class 
                 ON Enroll.classNumber == Class.classNumber 
                 AND Class.facId == 'F110' 
                 ORDER BY Enroll.stuId")
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Find course/class numbers and the names and majors of all students enrolled in the courses taught by Faculty member F110.
res<-dbSendQuery(con,"SELECT Student.firstName,Student.lastName,Student.major,Class.classNumber
                 FROM Student,Class
                 WHERE Student.stuId 
                 IN 
                 (Select Enroll.stuId 
                 FROM Enroll,Class 
                 WHERE Enroll.classNumber == Class.classNumber 
                 AND Class.facId =='F110')
                 AND Class.facId=='F110'")
  
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Find the names and IDs of all Faculty members who teach a class in Room H221.

res<-dbSendQuery(con,"SELECT Faculty.facId,Faculty.name
                 FROM Faculty
                 INNER JOIN Class
                 ON Faculty.facId == Class.facId
                 AND Class.room == 'H221'")
fetch(res)
dbClearResult(res)

#---------------------------------------------------------------------------------------------
# Find the names of all students enrolled in CSC201A.
res<-dbSendQuery(con,"SELECT Student.firstName,Student.lastName
                 FROM Student
                 WHERE Student.stuId
                 IN (SELECT Enroll.stuId 
                 FROM Enroll
                 WHERE Enroll.classNumber == 'CSC201A')")
fetch(res)
dbClearResult(res)

#---------------------------------------------------------------------------------------------
# Get an alphabetical list of names and IDs of all students in any class taught by F110.
res<-dbSendQuery(con,"SELECT Student.firstName,Student.lastName,Student.stuId
                 FROM Student
                 WHERE Student.stuId 
                 IN 
                 (Select Enroll.stuId 
                 FROM Enroll,Class 
                 WHERE Enroll.classNumber == Class.classNumber 
                 AND Class.facId =='F110')
                 ORDER BY Student.firstName")

fetch(res)
dbClearResult(res)

#---------------------------------------------------------------------------------------------
# Find the names of all students who are not enrolled in CSC201A.
res<-dbSendQuery(con,"SELECT Student.firstName,Student.lastName
                 FROM Student
                 WHERE Student.stuId 
                 NOT IN 
                 (Select Enroll.stuId 
                 FROM Enroll,Class 
                 WHERE Enroll.classNumber == Class.classNumber 
                 AND Class.facId =='CSC201A')")

fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
#Get IDs of all Faculty who are assigned to the history department or who teach in Room H221.
res<-dbSendQuery(con,"SELECT Faculty.facId
                 FROM Faculty
                 WHERE Faculty.department=='History'
                 OR Faculty.facId
                 IN (Select Faculty.facId 
                 FROM Faculty,Class
                 WHERE Faculty.facId==Class.facId 
                 AND Class.room =='H221')")
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Find the total number of students enrolled in ART103A. 
res<-dbSendQuery(con,"SELECT COUNT(Enroll.stuId) AS StudentInART103A
                 FROM Enroll
                 WHERE Enroll.classNumber=='ART103A'")
fetch(res)
dbClearResult(res)
#---------------------------------------------------------------------------------------------
# Find names and IDs of students who have less than the average number of credits. 
res<-dbSendQuery(con,"SELECT Student.stuId,Student.firstName,Student.lastName
                 FROM Student
                 WHERE Student.credits<(SELECT AVG(credits) FROM Student)")
fetch(res)
dbClearResult(res)

#---------------------------------------------------------------------------------------------
#Find all courses in which fewer than three students are enrolled.
res<-dbSendQuery(con,"SELECT classNumber
                 FROM (SELECT classNumber,COUNT(*) AS freq FROM Enroll 
                 GROUP BY classNumber)
                 WHERE freq<3")
fetch(res)
dbClearResult(res)

