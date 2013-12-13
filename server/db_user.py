import MySQLdb
import MySQLdb.cursors
 
class DbUser:
	 
	def __init__(self):
		self.db = MySQLdb.connect(host="127.0.0.1", # your host, usually localhost
					 user="root", # your username
					 passwd="", # your password
					 db="node_test_db",# name of the data base
					 cursorclass=MySQLdb.cursors.DictCursor)# allows query results as dicts 

		self.cur = self.db.cursor() 


	def getUserInfo(self, login):
		try:
			self.cur.execute("SELECT * FROM user WHERE login = %s", (login))
			return self.cur.fetchall()[0]
		except:
			self.db.rollback()
		
		
	def userInDb(self, login):
		
		self.cur.execute("SELECT count(1) FROM user WHERE login = %s", (login))
		return self.cur.fetchall()[0]["count(1)"] == 1


	def getToken(self, login):
		self.cur.execute("SELECT token FROM user WHERE login = %s", (login))
		return self.cur.fetchall()[0]
	

	def updateToken(self, token, login):
		try:
			self.cur.execute("""UPDATE user SET token = %s WHERE login = %s;""", (token, login))
			self.db.commit()
			print("shit went good")
		except MySQLdb.Error:
			print("error")

	def updateFailedAttempts(self, nbAttempts, login):
		self.cur.execute("UPDATE user SET attempts = %s WHERE login = %s;", (nbAttempts, login))
		self.db.commit()



	def getFailedAttemps(self, login):
		self.cur.execute("SELECT attempts FROM user WHERE login = %s", (login))
		return self.cur.fetchall()[0]

	def insertUser(self, login, pwd, salt, token):
		#token = 123
		try:
			self.cur.execute("""INSERT INTO user (login, salted_pwd, salt, token) VALUES (%s, %s, %s, %s) """, (login, pwd, salt, token))
			self.db.commit()
		except:
			self.db.rollback()


