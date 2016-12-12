import mysql.connector
from mysql.connector import errorcode


# Call this init and assign to variable in main class.
# This should then be passed to other modules using the database,
# so we are only using one database connection.
def __init__():
    # Enclose db connection in a try/except
    try:
        # This is the actual database connection event
        db = mysql.connector.connect(host="localhost",  # set host (usually localhost)
                                     user="dbpairr",  # set username
                                     passwd="robot",  # set password
                                     db="dbpairr")  # name of the database
        return db
    # Catches errors from MySQL connection
    # Gives us some custom error messages
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print ("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        elif err.errno == errorcode.CR_CONN_HOST_ERROR:
            print "Something went wrong with the connection"
            print "Is the server on ? :P"  # Take this out in prod.
        else:
            print(err)
        exit()


# This function will return an array of tuples that can be iterated over
def run_query_all(db, query, query_args=None):

    cur = db.cursor()
    if query_args is None:
        cur.execute(query)
    else:
        cur.execute(query, query_args)
    fetch = cur.fetchall()
    cur.close()
    return fetch


# This function returns a single tuple
def run_query_single(db, query, query_args=None):

    cur = db.cursor()
    if query_args is None:
        cur.execute(query)
    else:
        cur.execute(query, query_args)
    fetch = cur.fetchone()
    cur.close()
    return fetch



