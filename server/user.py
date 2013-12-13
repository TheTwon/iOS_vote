from db_user import DbUser
import hashlib, uuid
import os
import random

class User:
	"""
	class defining a user
	"""

	def __init__(self, login="", pwd=""):
		self.login = login
		self.pwd = pwd
		self.salt = ""
		self.dbUser = DbUser()
		self.fAttempts = 0

		if(login != ""):
			if(self.userExists(login)):
				uInfo = self.dbUser.getUserInfo(login)
				self.login = uInfo["login"]
				self.pwd = uInfo["salted_pwd"]#salty password
				self.salt = uInfo["salt"]
				self.fAttempts = uInfo["attempts"]
	

	
	def userExists(self, login):
		"""
		checks if a user exists (see also db_user.py)
		"""
		return self.dbUser.userInDb(self.login)
	
	

	def loginUser(self, givenPwd):
		"""
		login the user (checks credentials)
		"""
		return self.hashSaltPwd(givenPwd, self.salt) == self.pwd
		

	
	def createUser(self, login, pwd):
		"""
		creates a non existing user
		"""
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
	


	def hashSaltPwd(self, pwd, salt):
		"""
		salts and hashes a password
		"""
		spwd = pwd + salt
		return hashlib.sha512(spwd).hexdigest()
		

	def addFailedAttempt(self, login):

		self.dbUser.updateFailedAttempts(self.fAttempts + 1, login)
	

	def clearFailedAttempts(self, login):
		self.dbUser.updateFailedAttempts(0, login)


	def __str__(self):
		return self.login + " - " + self.pwd + " - " + self.salt
		


u = User("dummy")
u.clearFailedAttempts(u.login)