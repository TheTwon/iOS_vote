import db_tools



class DbResponse:

	def __init__(self):
		self.db = db_tools.getDB()
		self.cur = self.db.cursor()


	def getResponses(self, pollId):
		self.cur.execute("SELECT * FROM response WHERE fk_poll = %s", (pollId))
		return self.cur.fetchall()



	def responseInDb(self, pollId, userId, answerId):
		self.cur.execute("SELECT count(1) FROM response WHERE fk_poll = %s AND fk_user = %s AND fk_answer", (pollId, userId, answerId))
		return self.cur.fetchall()[0]["count(1)"] == 1


	def userResponseInDb(self, pollId, userId):
		self.cur.execute("SELECT count(1) FROM response WHERE fk_poll = %s AND fk_user = %s", (pollId, userId))
		return self.cur.fetchall()[0]["count(1)"] == 1