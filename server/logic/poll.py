from database.db_poll import DbPoll
from database.db_answer import DbAnswer
from database.db_response import DbResponse

class Poll:

	def __init__(self, pid = -1):
		self.dbPoll = DbPoll()
		self.dbAnswer = DbAnswer()
		self.dbResponse = DbResponse()
		self.pid = pid
		self.title = ""
		self.desc = ""

		if pid != -1:
			if self.dbPoll.pollInDb(pid):
				pInfo = self.dbPoll.getPollInfo(pid)
				self.title = pInfo["title"]
				self.desc = pInfo["description"]
				self.pid = pInfo["id"]



	def pollExists(self, pid):
		return self.dbPoll.pollInDb(pid)


	#??? 
	def pollAnswers(self):
		answers = self.dbAnswer.getAnswers(self.pid)
		return answers


	def pollInfo(self):
		
		pInfo = self.dbPoll.getPollInfo(self.pid)
		answers = self.dbAnswer.getAnswers(self.pid)
		
		for a in answers:
			del a["fk_poll"]

		pInfo["answers"] = answers
		return pInfo


	def formated(self):

		if not self.pollExists(self.pid):
			return {"status":"error", "error_type":"no such poll"}

		pi = self.pollInfo()
		pi["status"] = "ok"
		return pi


	def validAnswer(self, answerId):
		return self.dbAnswer.pollHasAnswer(answerId, self.pid)


	def hasUserAnswer(self, userId):
		return self.dbResponse.userResponseInDb(self.pid, userId)


	def answer(self, userId):
		pass



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