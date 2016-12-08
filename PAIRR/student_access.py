from db_access import run_query_single

# This prebaked query can be appended with a StudentNumber, retrieved from
# a barcode to provide the name of a Student
query_name = "SELECT `FirstName`,`LastName` FROM `tblstudent` WHERE `StudentNumber` = "


# Returns the first name of a student, given their student number
# Also has to be passed the database object.
def name(db, code):
    query = query_name + str(code)
    retrieved = run_query_single(db, query)[0]
    return retrieved


