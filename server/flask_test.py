from flask import Flask, jsonify, request
import MySQLdb
from user import User

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"


@app.route('/user_login', methods=['POST', 'GET'])
def login():
	
	login = request.args.get('login')
	pwd = request.args.get("pwd")
	
	if(login is None) or (pwd is None):
		return "bad parameter"
		
	reqUser = User(login)
	if(not reqUser.userExists(login)):
		return "no such user"
		
	if(not reqUser.loginUser(pwd)):
		return "bad password"
		
	#user is logged in at this point	
	return "login succesfull"




@app.route("/new_user")
def new_user():
		
	login = request.args.get('login')
	pwd = request.args.get("pwd")
	
	if(login is None) or (pwd is None):
		return "bad parameter"
	
	if login == "" or pwd == "":
		return "empty parameters"
	
	reqUser = User(login)
	if(reqUser.userExists(login)):
		return "user exists"
	
	reqUser.createUser(login, pwd)
	return "user created"
	
	

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
    




if __name__ == "__main__":
    app.run(host='0.0.0.0')
