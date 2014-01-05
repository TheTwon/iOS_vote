from flask import Flask, jsonify, request
import MySQLdb
import json
from logic.user import User
from logic.poll import Poll
from flask import render_template
from flask.ext.mail import Mail
from flask.ext.mail import Message
from flask import Response


app = Flask(__name__)



@app.route("/")
def hello():
    return jsonify(status="ok", info="root page")



@app.route('/login', methods=['GET'])
def login():
	
	login = request.args.get('login')
	pwd = request.args.get("pwd")
	
	if(login is None) or (pwd is None):
		return jsonify(status="error", error_type="bad parameter")
		
	reqUser = User(login)
	if(not reqUser.userExists(login)):
		return jsonify(status="error", error_type="no such user")
	

	if(reqUser.isUserBanned()):
		return jsonify(status="error", error_type="user banned")

	if(not reqUser.loginUser(pwd)):
		if(reqUser.shouldBeBanned()):
			reqUser.banUser()
			return jsonify(status="error", error_type="user banned")

		return jsonify(status="error", error_type="bad password")
	
	#user is logged in at this point	
	return jsonify(status="ok", info="user logged in", token = reqUser.updateToken())

@app.route("/post_test", methods=['POST'])
def post_test():
	print(request.json)
	return jsonify(request.json)



@app.route("/new_user", methods=['POST'])
def new_user():
	"""	
	login = request.args.get('login')
	pwd = request.args.get("pwd")
	
	if(login is None) or (pwd is None):
		return jsonify(status="error", error_type="bad parameter")
	
	if login == "" or pwd == "":
		return jsonify(status="error", error_type="empty parameters")
	
	reqUser = User(login)
	if(reqUser.userExists(login)):
		return jsonify(status="error", error_type="user exists")
	
	print("adding user")
	reqUser.createUser(login, pwd)
	return jsonify(status="ok", info="user created")
	"""

	content = request.json
	params = ["login", "pwd"]
	missing = []
	for p in params:
		if p not in content:
			missing.append(p)
	
	if len(missing) != 0:
		return jsonify(status="error", error_type="bad parameter", missing=missing)


	#user credentials check
	ulogin = content["login"]
	upwd = content["pwd"]

	reqUser = User(ulogin)
	if(reqUser.userExists(ulogin)):
		return jsonify(status="error", error_type="user exists")
	
	print("adding user")
	reqUser.createUser(ulogin, upwd)
	return jsonify(status="ok", info="user created")


	


@app.route("/polls", methods=['GET'])
def polls():
	
	ulogin = request.args.get('login')
	utoken = request.args.get("token")


	if(ulogin is None) or (utoken is None):
		return jsonify(status="error", error_type="bad parameter")
	
	if ulogin == "" or utoken == "":
		return jsonify(status="error", error_type="empty parameters")
	
	reqUser = User(ulogin)
	if(not reqUser.userExists(login)):
		return jsonify(status="error", error_type="no such user")

	if(not reqUser.loginUser(token=utoken)):
		return jsonify(status="error", error_type="bad token")

	return Response(json.dumps(reqUser.getUserPolls()), mimetype='application/json')




@app.route("/unanswered_polls", methods=['GET'])
def UaPolls():
	
	ulogin = request.args.get('login')
	utoken = request.args.get("token")


	if(ulogin is None) or (utoken is None):
		return jsonify(status="error", error_type="bad parameter")
	
	if ulogin == "" or utoken == "":
		return jsonify(status="error", error_type="empty parameters")
	
	reqUser = User(ulogin)
	if(not reqUser.userExists(login)):
		return jsonify(status="error", error_type="no such user")
	
	if(not reqUser.loginUser(token=utoken)):
		return jsonify(status="error", error_type="bad token")

	l = reqUser.getUnansweredUserPolls()
	d = {"status": "ok"}
	d["votes"] = l
	return Response(json.dumps(d), mimetype='application/json')



@app.route("/answered_polls", methods=['GET'])
def APolls():
	
	ulogin = request.args.get('login')
	utoken = request.args.get("token")


	if(ulogin is None) or (utoken is None):
		return jsonify(status="error", error_type="bad parameter")
	
	if ulogin == "" or utoken == "":
		return jsonify(status="error", error_type="empty parameters")

	reqUser = User(ulogin)
	if(not reqUser.userExists(login)):
		return jsonify(status="error", error_type="no such user")
	
	if(not reqUser.loginUser(token=utoken)):
		return jsonify(status="error", error_type="bad token")
	
	l = reqUser.getAnsweredUserPolls()
	d = {"status": "ok"}
	d["votes"] = l
	return Response(json.dumps(d), mimetype='application/json')



@app.route("/poll", methods=['GET'])
def poll():

	ulogin = request.args.get('login')
	utoken = request.args.get("token")
	pollId = request.args.get("poll_id")

	if(ulogin is None) or (utoken is None) or (pollId is None):
		return jsonify(status="error", error_type="bad parameter")
	
	if ulogin == "" or utoken == "" or pollId == "":
		return jsonify(status="error", error_type="empty parameters")
	
	reqUser = User(ulogin)
	if(not reqUser.userExists(login)):
		return jsonify(status="error", error_type="no such user")
	

	if(not reqUser.loginUser(token=utoken)):
		return jsonify(status="error", error_type="bad token")

	p = reqUser.getUserPoll(pollId)

	return jsonify(p)



@app.route('/poll/<login>/<int:poll_id>' )
def pollFromId(poll_id, login, methods=['GET']):
	# similar to /poll route

	utoken = request.args.get("token")
	if utoken is None:
		return jsonify(status="error", error_type="bad parameter")

	if utoken == "":
		return jsonify(status="error", error_type="empty parameters")
	
	reqUser = User(login)
	if(not reqUser.userExists(login)):
		return jsonify(status="error", error_type="no such user")
	
	if(not reqUser.loginUser(token=utoken)):
		return jsonify(status="error", error_type="bad token")

	p = reqUser.getUserPoll(poll_id)

	return jsonify(p)





@app.route("/change_password", methods=['POST', 'GET'])
def changePwd():

	email = request.args.get('email')

	if email is None:
		return jsonify(status="error", error_type="empty parameters")

	mail = Mail(app)
	msg = Message("lol",
                  sender="no-reply@example.com",
                  recipients=["jean@sabourin.eu"])
	msg.body = "testing"
	#mail.send(msg)
	return jsonify(status="ok", info="mail sent NYI")




@app.route("/answer_poll", methods=['POST'])
def answserPoll():
	content = request.json
	print(content)
	params = ["login", "token", "poll_id", "answer_id"]
	missing = []
	for p in params:
		if p not in content:
			missing.append(p)
	
	if len(missing) != 0:
		return jsonify(status="error", error_type="bad parameter", missing=missing)


	#user credentials check
	ulogin = content["login"]
	utoken = content["token"]
	upollId = content["poll_id"]
	answerId = content["answer_id"]

	reqUser = User(ulogin)

	if(not reqUser.userExists(ulogin)):
		return jsonify(status="error", error_type="no such user")
	
	if(not reqUser.loginUser(token=utoken)):
		return jsonify(status="error", error_type="bad token")


	#check poll integrity
	p = reqUser.getUserPoll(upollId, formated=False)
	if not p.pollExists(upollId):
		return jsonify(status="error", error_type="no such poll for user")


	if not reqUser.hasAnsweredPoll(upollId):
		return jsonify(status="error", error_type="previous user response to poll")	

	if not p.validAnswer(answerId):
		return jsonify(status="error", error_type="invalid answer ID")

	reqUser.answerUserPoll(upollId, answerId)
	return jsonify(status="ok", info="answered poll")
	#return jsonify(content)



#@app.route('/user/<username>')
#def show_user_profile(username):
#    # show the user profile for that user
#    return 'User %s' % username


#@app.route('/post/<int:post_id>')
#def show_post(post_id):
#    # show the post with the given id, the id is an integer
#    return 'Post %d' % post_id


    
#error handling
@app.errorhandler(400)
def page_not_found(e):
	print(dict(e))
	return jsonify(status="error", error_type="400"), 400


@app.errorhandler(404)
def page_not_found(e):
	print(e)
	return jsonify(status="error", error_type="404"), 404


@app.errorhandler(410)
def internal_error(e):
	print(e)
	return jsonify(status="error", error_type="410"), 410


@app.errorhandler(500)
def internal_error(e):
	#import pdb
	#pdb.set_trace()
	print(e)
	return jsonify(status="error", error_type="500"), 500



	

if __name__ == "__main__":
    app.run(host='0.0.0.0')
