
import db_tools


class DbPoll:


	def __init__(self):
		self.db = db_tools.getDB()
		self.cur = self.db.cursor()



	def pollInDb(self, pid):
		
		self.cur.execute("SELECT count(1) FROM poll WHERE id = %s", (pid))
		return self.cur.fetchall()[0]["count(1)"] == 1



	def getPollInfo(self, pid):
		try:
			self.cur.execute("SELECT * FROM poll WHERE id = %s", (pid))
			return self.cur.fetchall()[0]
		except:
			self.db.rollback()


	def getPolls(self):
		self.cur.execute("SELECT * FROM poll")
		return self.cur.fetchall()


	def getUnansweredPolls(self, uid):
		self.cur.execute("""SELECT * FROM poll
							WHERE id NOT IN (SELECT fk_poll from response WHERE fk_user = %s);""", (uid))
		return self.cur.fetchall()

		


