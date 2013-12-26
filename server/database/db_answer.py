import db_tools



class DbAnswer:
	
	def __init__(self):
		self.db = db_tools.getDB()
		self.cur = self.db.cursor()



	def getAnswers(self, pollId):
		self.cur.execute("SELECT * FROM answer WHERE fk_poll = %s", (pollId))
		return self.cur.fetchall()


	def pollHasAnswer(self, aid, pid):
		self.cur.execute("SELECT count(1) FROM answer WHERE id = %s AND fk_poll = %s", (aid, pid))
		return self.cur.fetchall()[0]["count(1)"] == 1

