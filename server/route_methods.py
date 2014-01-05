from flask import Flask, jsonify, request
import MySQLdb
import json
from logic.user import User
from logic.poll import Poll



def login(login, pwd):

	
	if(login is None) or (pwd is None):
		return jsonify(status="error", error_type="bad parameter")
	
	if(login == "") or (pwd == ""):
		return jsonify(status="error", error_type="empty parameter")

	reqUser = User(login)
	if(not reqUser.userExists(login)):
		return jsonify(status="error", error_type="no such user")
	

	if(reqUser.isUserBanned()):
		return jsonify(status="error", error_type="user banned", ban_time=reqUser.getBanTime())

	if(not reqUser.loginUser(pwd)):
		if(reqUser.shouldBeBanned()):
			reqUser.banUser()
			return jsonify(status="error", error_type="user banned", ban_time=reqUser.getBanTime())

		return jsonify(status="error", error_type="bad password")
	
	#user is logged in at this point	
	return jsonify(status="ok", info="user logged in", token = reqUser.updateToken())


def new_user(login, content):

	
	if "pwd" not in content:
		return jsonify(status="error", error_type="bad parameter", missing="pwd")

	#user credentials check
	ulogin = login
	upwd = content["pwd"]

	reqUser = User(ulogin)
	if(reqUser.userExists(ulogin)):
		return jsonify(status="error", error_type="user exists")
	
	print("adding user")
	reqUser.createUser(ulogin, upwd)
	return jsonify(status="ok", info="user created")


