# HARVARD REFERENCING - http://stackoverflow.com/questions/372885/how-do-i-connect-to-a-mysql-database-in-python
# !/usr/bin/python

# Connecting MYSQL with Python
import mysql.connector
# Imports error code
from mysql.connector import errorcode

# Constructor creates connection to MySQL server
try:
    db = mysql.connector.connect(host="localhost",  # set host (usually localhost)
                                 user="dbpairr",    # set username
                                 passwd="robot",    # set password
                                 db="dbpairr")      # name of the database

# Catches errors from MySQL connection
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print ("Something is wrong with your user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    elif err.errno == errorcode.CR_CONN_HOST_ERROR:
        print "Something went wrong with the connection"
        print "Is the server on ? :P" #Take this out in prod.
    else:
        print(err)
    exit()

# Creating a cursor object, allows you execute all the queries you need
cur = db.cursor(buffered=True)
print "Is the data base connected? " + db.is_connected().__str__()
print "What's in the cursor?: " + cur.__str__()
# cur.execute("INSERT ")
# Run an SQL question (Shows which version of SQL is being used)
# DON'T THINK THIS LINE OF CODE DOES MUCH, IF ANYTHING SO MAY DELETE
version = cur.execute("SELECT VERSION() LIMIT 1")
print "Whats the next line stored in the cursor?: " + cur.next()[0]
# Executes SQL queries
# The asterisk selects all columns in the table
# This buffers the query results, does not distinguish between 1 and many
cur.execute("SELECT `ALevelName` FROM `tblalevel` WHERE `ALevelID` = 1")
data = cur.fetchone()
print "The ALevel list with ALevel ID 1 is " + data[data.__len__()-1]
# THERE IS AN ISSUE WITH THE TBLALEVEL_DEGREE LINE BELOW
cur.execute("SELECT * FROM `tblalevel_degree`")
relationships = cur.fetchall()
for ALevel_DegreeID, ALevelID, DegreeID, Relationship in relationships:
    print "ALevel_DegreeID | ALevelID | DegreeID | Relationship"
    print str(ALevel_DegreeID) + " | " + str(ALevelID) + " | " + str(DegreeID) + " | " + str(Relationship)
'''cur.execute("SELECT * FROM `tbldegree`")
cur.execute("SELECT * FROM `tblstudent`")
cur.execute("SELECT * FROM `tblstudent_alevel`")

# NEED TO REVIEW THIS JOIN QUERY AND GET RID OF INPUTS THAT AREN'T NEEDED TO JOIN
# Join Query (Allows normalized tables to join, and share data)
# Connecting tblalevel_degree to tblstudent_alevel
cur.exectue("SELECT tblalevel_degree.ALevel_DegreeID, tblalevel_degree.ALevelID, \
tblalevel_degree.DegreeID, tblalevel_degree.Relationship, \
tblstudent_alevel.Student_ALevelID, tblstudent_alevel.StudentID, \
tblstudent_alevel.ALevelID AS StudentALevelDegree \
FROM tblalevel_degree JOIN tblstudent_alevel ON tblalevel_degree.ALevelID \
= tblstudent_alevel.ALevelID GROUP BY tblstudent_alevel.StudentID \
tblalevel_degree.ALevelID, tblalevel_degree.DegreeID, tblalevel_degree.Relationship")

# Fetch all rows using fetchall() method
data = cur.fetchall()
'''
# Print




# Disconnecting from MySQL server, closing database connection
db.close()
