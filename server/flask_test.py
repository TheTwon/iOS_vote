from flask import Flask, jsonify, request
import MySQLdb
from user import User
from flask import render_template
from flask.ext.mail import Mail
from flask.ext.mail import Message


app = Flask(__name__)



@app.route("/")
def hello():
    return "Hello World!"



@app.route('/login', methods=['POST', 'GET'])
def login():
	
	login = request.args.get('login')
	pwd = request.args.get("pwd")
	
	if(login is None) or (pwd is None):
		return jsonify(status="error", error_type="bad parameter")
		
	reqUser = User(login)
	if(not reqUser.userExists(login)):
		return jsonify(status="error", error_type="no such user")
		
	if(not reqUser.loginUser(pwd)):
		return jsonify(status="error", error_type="bad password")
	
	#user is logged in at this point	
	return jsonify(status="ok", info="user logged in", token = reqUser.updateToken())




@app.route("/new_user", methods=['POST', 'GET'])
def new_user():
		
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
	
	

#test routes to be deleted	
@app.route("/poll", methods=['POST', 'GET'])
def poll():
	
	ulogin = request.args.get('login')
	utoken = request.args.get("token")


	if(ulogin is None) or (utoken is None):
		return jsonify(status="error", error_type="bad parameter")
	
	if ulogin == "" or utoken == "":
		return jsonify(status="error", error_type="empty parameters")
	
	reqUser = User(ulogin)
	if(not reqUser.loginUser(token=utoken)):
		return jsonify(status="error", error_type="bad token")

	return jsonify(status="ok", info="todo")
   



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
	return str(content)




#@app.route('/user/<username>')
#def show_user_profile(username):
#    # show the user profile for that user
#    return 'User %s' % username


#@app.route('/post/<int:post_id>')
#def show_post(post_id):
#    # show the post with the given id, the id is an integer
#    return 'Post %d' % post_id


    
#error page
@app.errorhandler(400)
def page_not_found(e):
	print(e)
	return jsonify(status="error", error_type="400"), 400


@app.errorhandler(404)
def page_not_found(e):
	print(e)
	return jsonify(status="error", error_type="404"), 404

@app.errorhandler(500)
def internal_error(e):
	print(e)
	return jsonify(status="error", error_type="500"), 500
	

if __name__ == "__main__":
    app.run(host='0.0.0.0')
