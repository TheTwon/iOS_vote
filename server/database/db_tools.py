import MySQLdb
import MySQLdb.cursors


def getDB():
	return MySQLdb.connect(host="127.0.0.1", # your host, usually localhost
					 user="root", # your username
					 passwd="", # your password
					 db="node_test_db",# name of the data base
					 cursorclass=MySQLdb.cursors.DictCursor)# allows query results as dicts

