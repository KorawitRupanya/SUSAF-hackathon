from flask import Flask, request, jsonify
#from flasgger import Swagger
import json

from datetime import datetime, timedelta

import openai

import os

from SQL_Function import SQL_Function

import argparse

#pip install openapi
#pip install json
#pip install Flask Flask-RESTful flasgger Swagger-UI

app = Flask(__name__)
#swagger = Swagger(app)

mysql_ip = ""
mysql_user = ""
mysql_password = ""

OpenAPI_Key = "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"

#GET LIST OF QUESTIONS
@app.route("/questions", methods=["GET"])
#@swagger.doc(description='Get SusAF Framework questions')
def questionList():
	"""
	Get SusAF Framework questions
	---
	responses:
		200:
			description: A list of SusAF Framework questions
	"""
	sql = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	rows = sql.select("SELECT * from questions")
	return jsonify(rows)
	#return json.dumps(rows)


#ANSWER FROM USER
@app.route("/answer", methods=["POST"])
#@swagger.doc(description='Save user answer from SuSAF Framework questions')
def pushAnswers():

	req_data = request.get_json()
	Features_ID = req_data.get("Features_ID")
	Questions_ID = req_data.get("Questions_ID")
	Answers = req_data.get("Answers")
	chatgpt = req_data.get("chatgpt", False)  # default to False if not present in request data
	edited = req_data.get("edited", False)  # default to False if not present in request data

	sql_func = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	query = "INSERT INTO answer(Features_ID, Questions_ID, Answers, chatgpt, edited) VALUES (%s, %s, %s, %s, %s)"
	values = (Features_ID, Questions_ID, Answers, chatgpt, edited)
	sql_func.insert(query, values)

	return {"pushResult": "OK"}


@app.route("/answers_featureID", methods=["GET"])
#@swagger.doc(description='View user answer from SuSAF Framework questions according to its feature ID')
def viewAnswerPerFeatureID():
	Features_ID = request.args.get("Features_ID", None) # Extract the FeaturesID query parameter from the request
	answerID = request.args.get("answerID", None) # Extract the answerID query parameter from the request, or set it to None if not present

	if not Features_ID and not answerID:
		return jsonify({"error": "Please provide either a Features_ID or an Answer_ID"})

	# Build a SQL query to retrieve the matching feature
	sql = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	
	if Features_ID and answerID :
		rows = sql.select("SELECT ID, Features_ID, Questions_ID, Answers, chatgpt, edited from answer WHERE Features_ID = '" + Features_ID + "' AND ID = " + answerID)
	elif Features_ID:
		rows = sql.select("SELECT ID, Features_ID, Questions_ID, Answers, chatgpt, edited from answer WHERE Features_ID = '" + Features_ID + "'")
	else:
		rows = sql.select("SELECT ID, Features_ID, Questions_ID, Answers, chatgpt, edited from answer WHERE ID = " + answerID)

	return jsonify(rows)
	#return json.dumps(rows)



#PROMPT FROM OPEN API
@app.route("/promptGPT", methods=["POST"])
#@swagger.doc(description='Generate answer from ChatGPT')
def promptOpenAPI():
	req_data = request.get_json()
	prompt = req_data.get("prompt")

	# Define OpenAI API key 
	openai.api_key = OpenAPI_Key

	# Set up the model and prompt
	model_engine = "text-davinci-003"
	#prompt = "I want to make system that can automatically give Ethiopian farmer suggestion of how to do planting rice"
	#prompt += "\n" + "How are materials consumed to produce the product or service? ";

	# Generate a response
	completion = openai.Completion.create(
		engine=model_engine,
		prompt=prompt,
		max_tokens=1024,
		n=1,
		stop=None,
		temperature=0.5,
	)

	response = str(completion.choices[0].text)
	#return json.dumps(rows)
	#print(response)
	return {"AIResult": response}


#PROMPT FROM OPEN API
@app.route("/dimensionGPT", methods=["POST"])
#@swagger.doc(description='Generate answer from ChatGPT')
def promptOpenAPIPerDimension():
	req_data = request.get_json()
	dimension = req_data.get("dimension")
	Features_ID = req_data.get("Features_ID")

	sql = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	rows = sql.select(" SELECT Answers FROM answer INNER JOIN questions ON questions.Questions_ID = answer.Questions_ID WHERE questions.Questions_Header = '"+dimension+"' AND Features_ID = " + Features_ID)

	prompt = 'Summary this sentences into 5 bullet points, which each consist of a sentence with 5-8 words : \n'
	for row in rows:
		prompt += str(row[0]) + '\n'

	# Define OpenAI API key 
	openai.api_key = OpenAPI_Key

	# Set up the model and prompt
	model_engine = "text-davinci-003"
	#prompt = "I want to make system that can automatically give Ethiopian farmer suggestion of how to do planting rice"
	#prompt += "\n" + "How are materials consumed to produce the product or service? ";

	# Generate a response
	completion = openai.Completion.create(
		engine=model_engine,
		prompt=prompt,
		max_tokens=1024,
		n=1,
		stop=None,
		temperature=0.5,
	)

	response = str(completion.choices[0].text)

	print("Answer : " + prompt)

	return {"AIResult": response}




#PROJECT MANAGEMENT
@app.route("/projects", methods=["POST"])
#@swagger.doc(description='Make new project')
def createProject():
	req_data = request.get_json()
	title = req_data.get("title")
	description = req_data.get("description")

	sql_func = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	query = "INSERT INTO projects(title, description) VALUES (%s, %s)"
	values = (title, description)
	sql_func.insert(query, values)
	return {"pushResult": "OK"}

@app.route("/projects", methods=["GET"])
#@swagger.doc(description='View all projects')
def viewProject():
	sql = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	rows = sql.select("SELECT Project_ID, title, description from projects")
	return jsonify(rows)
	#return json.dumps(rows)

@app.route("/projectID", methods=["GET"])
#@swagger.doc(description='View project according to its ID')
def viewProjectPerID():
	# Extract the FeaturesID query parameter from the request
	projects_id = request.args.get("Project_ID")

	# Build a SQL query to retrieve the matching feature
	sql = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	rows = sql.select("SELECT Project_ID, title, description from projects WHERE Project_ID='"+str(projects_id)+"'")
	return jsonify(rows)
	#return json.dumps(rows)



#FEATURES MANAGEMENT
@app.route("/features", methods=["POST"])
#@swagger.doc(description='Create new feature')
def createFeature():
	req_data = request.get_json()
	Project_ID = req_data.get("Project_ID")
	Features_Name = req_data.get("Features_Name")

	sql_func = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	query = "INSERT INTO features(Project_ID, Features_Name) VALUES (%s, %s)"
	values = (Features_Name, Project_ID)
	sql_func.insert(query, values)
	return {"pushResult": "OK"}

@app.route("/features", methods=["GET"])
#@swagger.doc(description='View all features')
def viewFeature():
	sql = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	rows = sql.select("SELECT Features_ID, Project_ID, Features_Name from features")
	return jsonify(rows)
	#return json.dumps(rows)

@app.route("/featureID", methods=["GET"])
#@swagger.doc(description='View a feature according to its ID')
def viewFeaturePerID():
	# Extract the FeaturesID query parameter from the request
	features_id = request.args.get("FeatureID")

	# Build a SQL query to retrieve the matching feature
	sql = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	rows = sql.select("SELECT Project_ID, Features_Name from features WHERE Features_ID='"+str(features_id)+"'")
	return jsonify(rows)
	#return json.dumps(rows)

@app.route("/features_projectID", methods=["GET"])
#@swagger.doc(description='View all features under a certain projectID')
def viewFeaturePerProjectID():
	# Extract the FeaturesID query parameter from the request
	project_id = request.args.get("ProjectID")

	# Build a SQL query to retrieve the matching feature
	sql = SQL_Function(ipMySQL=mysql_ip, userMySQL=mysql_user, passwordMySQL=mysql_password)
	rows = sql.select("SELECT Features_ID, Features_Name from features WHERE Project_ID ='"+str(project_id)+"'")
	return jsonify(rows)
	#return json.dumps(rows)





if __name__ == "__main__":
	parser = argparse.ArgumentParser(description='Description of your program')
	parser.add_argument('-i','--ip', help='MySQL IP address', required=True)
	parser.add_argument('-u','--user', help='MySQL username', required=False)
	parser.add_argument('-p','--password', help='MySQL password', required=False)
	args = parser.parse_args()

	mysql_ip = args.ip
	mysql_user = args.user
	if args.password:
		mysql_password = args.password
	else :
		mysql_password = ""

	app.run(debug=True, port=8001)