import db_access

def __init__():
    print "Network launching"

    load_state()

def load_state():
    load_query = ""
    db = db_access.__init__()
    db_access.run_query_all(db, load_query)