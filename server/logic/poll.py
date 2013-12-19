from database.db_poll import DbPoll


class Poll:

	def __init__(self, pid = -1):
		self.dbPoll = DbPoll() 
		self.pid = pid
		self.title = ""
		self.desc = ""

		if pid != -1:
			if self.dbPoll.pollInDb(pid):
				pInfo = self.dbPoll.getPollInfo(pid)
				self.title = pInfo["title"]
				self.desc = pInfo["description"]


	def pollExists(self, pid):
		return self.dbPoll.pollInDb(pid)


	@classmethod
	def getPollList(self):
		tmpDbPoll = DbPoll()
		return tmpDbPoll.getPolls()


	@classmethod
	def getUnansweredPollList(self, uid):
		tmpDbPoll = DbPoll()
		return tmpDbPoll.getUnansweredPolls(uid)

	@classmethod
	def getAnsweredPollList(self, uid):
		tmpDbPoll = DbPoll()
		return tmpDbPoll.getAnsweredPolls(uid)