from database.db_user import DbUser
from poll import Poll
import hashlib, uuid
import os
import random
import time

class User:
	"""
	class defining a user
	"""

	AUTH_AT = 10

	def __init__(self, login="", pwd=""):
		self.login = login
		self.pwd = pwd
		self.salt = ""
		self.dbUser = DbUser()
		self.fAttempts = 0

		if(login != ""):
			if(self.userExists(login)):
				uInfo = self.dbUser.getUserInfo(login)
				#retrieve only perssistent info
				self.login = uInfo["login"]
				self.pwd = uInfo["salted_pwd"]#salty password
				self.salt = uInfo["salt"]
				self.fAttempts = uInfo["attempts"]
	

	
	def userExists(self, login):
		"""
		checks if a user exists (see also db_user.py)
		"""
		return self.dbUser.userInDb(self.login)
	
	

	def loginUser(self, givenPwd="", token=""):
		"""
		login the user (checks credentials)
		TODO check if user exists
		"""

		if givenPwd != "":
			if self.hashSaltPwd(givenPwd, self.salt) == self.pwd:
				return True
			
			self.addFailedAttempt(self.login)
			return False

		if token != "":
			uToken = self.dbUser.getToken(self.login)["token"]
			return token == uToken

		return False

	
	def createUser(self, login, pwd):
		"""
		creates a non existing user
		"""
		print("creating user")
		if not self.userExists(login):
			salt = self.generateSalt()
			spwd = self.hashSaltPwd(pwd, salt)
			token = self.generateToken()
			self.dbUser.insertUser(login, spwd, salt , token)

			self.login = login
			self.pwd = spwd
			self.salt = salt
	


	def generateSalt(self):
		"""
		generates and returns a unique salt (different at each call)
		"""
		return str(uuid.uuid4().hex)
		


	def generateToken(self):
		"""
		generates and returns a unique token 
		"""
		return uuid.uuid4().hex
	
	
	def updateToken(self):
		"""
		fully updates the users token
		"""
		if self.userExists(self.login):
			#calls to db
			self.dbUser.changeToken(self.generateToken(), self.login)
			self.dbUser.updateTokenValidity(int(time.time()), self.login)
			return self.dbUser.getToken(self.login)["token"]
		
		return False
		



	def hashSaltPwd(self, pwd, salt):
		"""
		salts and hashes a password
		"""
		spwd = pwd + salt
		return hashlib.sha512(spwd).hexdigest()
		


	def addFailedAttempt(self, login):
		self.dbUser.updateFailedAttempts(self.fAttempts + 1, login)
		self.fAttempts = self.dbUser.getFailedAttemps(login)



	def clearFailedAttempts(self, login):
		self.dbUser.updateFailedAttempts(0, login)



	def banned(self):
		if self.userExists(self.login):
			attemps = self.dbUser.getAttemps(self.login)["attempts"]
			return attempts < User.AUTH_AT


	def getUserId(self):
		return self.dbUser.getId(self.login)["id"]


	def getUserPoll(self, pollId, formated=True):
		p = Poll(pollId)

		if formated:
			return p.formated()

		return p


	def hasAnsweredPoll(self, pollId):
		p = Poll(pollId)

		if p.pollExists(pollId):
			return not p.hasUserAnswer(self.getUserId())

		return False

	def getUserPolls(self):
		return Poll.getPollList()


	def getUnansweredUserPolls(self):
		return list(Poll.getUnansweredPollList(self.getUserId()))


	def getAnsweredUserPolls(self):
		return list(Poll.getAnsweredPollList(self.getUserId()))


	def answerUserPoll(self, pollId):
		pass

	def __str__(self):
		return self.login + " - " + self.pwd + " - " + self.salt

