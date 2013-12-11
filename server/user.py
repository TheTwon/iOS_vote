from db_user import DbUser
import hashlib, uuid
import os
import random

class User:
	

	def __init__(self, login="", pwd=""):
		self.login = login
		self.pwd = pwd
		self.salt = ""
		self.dbUser = DbUser()
		
		if(login != ""):
			if(self.userExists(login)):
				uInfo = self.dbUser.getUserInfo(login)
				self.login = uInfo["login"]
				self.pwd = uInfo["salted_pwd"]#salty password
				self.salt = uInfo["salt"]
	

	
	def userExists(self, login):
		return self.dbUser.userInDb(self.login)
	
	

	def loginUser(self, givenPwd):
		return self.saltPwd(givenPwd, self.salt) == self.pwd
		

	
	def createUser(self, login, pwd):
		if not self.userExists(login):
			salt = self.generateSalt()
			spwd = self.saltPwd(pwd, salt)
			token = self.generateToken()
			self.dbUser.insertUser(login, spwd, salt , token)

			self.login = login
			self.pwd = spwd
			self.salt = salt
	


	def generateSalt(self):
		return str(uuid.uuid4().hex)
		


	def generateToken(self):
		return  uuid.uuid4().hex #TODO
	


	def saltPwd(self, pwd, salt):
		spwd = pwd + salt
		return hashlib.sha512(spwd).hexdigest()
		

	
	def __str__(self):
		return self.login + " - " + self.pwd + " - " + self.salt
