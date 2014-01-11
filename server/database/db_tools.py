import pymysql


def getDB():
	return pymysql.connect(host="127.0.0.1", # your host, usually localhost
					 user="root", # your username
					 passwd="", # your password
					 db="node_test_db",# name of the data base
					 cursorclass=pymysql.cursors.DictCursor)# allows query results as dicts

