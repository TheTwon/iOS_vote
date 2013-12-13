from flask import Flask, jsonify, request
import MySQLdb
from user import User
from flask import render_template


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





@app.route("/new_user")
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
	
	reqUser.createUser(login, pwd)
	return jsonify(status="ok", info="user created")
	
	

#test routes to be deleted	
	
@app.route("/poll")
def poll():
    return "{service:poll}"
   

@app.route('/user/<username>')
def show_user_profile(username):
    # show the user profile for that user
    return 'User %s' % username

@app.route('/post/<int:post_id>')
def show_post(post_id):
    # show the post with the given id, the id is an integer
    return 'Post %d' % post_id
    
#error page
@app.errorhandler(404)
def page_not_found(e):
	return jsonify(status="error", error_type="404"), 404
	

if __name__ == "__main__":
    app.run(host='0.0.0.0')
