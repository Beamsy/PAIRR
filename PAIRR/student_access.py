from db_access import run_query_single

# This prebaked query can be appended with a StudentNumber, retrieved from
# a barcode to provide the name of a Student
query_name = "SELECT `FirstName`,`LastName` FROM `tblstudent` WHERE `StudentNumber` = "
# This prebaked query can be appended with a StudentNumber, retrieved from
# a barcode to provide the alevels a student studies
query_a_lvls = "SELECT `ALevel1`,`ALevel2`,`ALevel3` FROM `tblstudent` WHERE `StudentNumber` = "


# Returns the first name of a student, given their student number
# Also has to be passed the database object.
def get_name(db, code):
    query = query_name + str(code)
    retrieved = run_query_single(db, query)[0]
    return retrieved


# Returns the id numbers of the ALevels studied by a student given their student number
# Also has to be passed the database object
def get_a_lvls(db, code):
    query = query_a_lvls + str(code)
    retrieved = run_query_single(db, query)
    print retrieved
    return retrieved
