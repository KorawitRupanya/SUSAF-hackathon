from flask import Flask, request, jsonify
#from flasgger import Swagger
import json

from datetime import datetime, timedelta

import openai

from SQL_Function import SQL_Function

#pip install openapi
#pip install json
#pip install Flask Flask-RESTful flasgger Swagger-UI

app = Flask(__name__)
#swagger = Swagger(app)

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
	sql = SQL_Function()
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

	sql_func = SQL_Function()
	query = "INSERT INTO answer(Features_ID, Questions_ID, Answers) VALUES (%s, %s, %s)"
	values = (Features_ID, Questions_ID, Answers)
	sql_func.insert(query, values)
	return {"pushResult": "OK"}


@app.route("/answers_featureID", methods=["GET"])
#@swagger.doc(description='View user answer from SuSAF Framework questions according to its feature ID')
def viewAnswerPerFeatureID():
	# Extract the FeaturesID query parameter from the request
	Features_ID = request.args.get("Features_ID")

	# Build a SQL query to retrieve the matching feature
	sql = SQL_Function()
	rows = sql.select("SELECT ID, Features_ID, Questions_ID, Answers from answer WHERE Features_ID ='"+str(Features_ID)+"'")
	return jsonify(rows)
	#return json.dumps(rows)



#PROMPT FROM OPEN API
@app.route("/promptGPT", methods=["POST"])
#@swagger.doc(description='Generate answer from ChatGPT')
def promptOpenAPI():
	req_data = request.get_json()
	prompt = req_data.get("prompt")

	# Define OpenAI API key 
	openai.api_key = "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"

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


#PROJECT MANAGEMENT
@app.route("/projects", methods=["POST"])
#@swagger.doc(description='Make new project')
def createProject():
	req_data = request.get_json()
	title = req_data.get("title")
	description = req_data.get("description")

	sql_func = SQL_Function()
	query = "INSERT INTO projects(title, description) VALUES (%s, %s)"
	values = (title, description)
	sql_func.insert(query, values)
	return {"pushResult": "OK"}

@app.route("/projects", methods=["GET"])
#@swagger.doc(description='View all projects')
def viewProject():
	sql = SQL_Function()
	rows = sql.select("SELECT Project_ID, title, description from projects")
	return jsonify(rows)
	#return json.dumps(rows)

@app.route("/projectID", methods=["GET"])
#@swagger.doc(description='View project according to its ID')
def viewProjectPerID():
	# Extract the FeaturesID query parameter from the request
	projects_id = request.args.get("Project_ID")

	# Build a SQL query to retrieve the matching feature
	sql = SQL_Function()
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

	sql_func = SQL_Function()
	query = "INSERT INTO features(Project_ID, Features_Name) VALUES (%s, %s)"
	values = (Features_Name, Project_ID)
	sql_func.insert(query, values)
	return {"pushResult": "OK"}

@app.route("/features", methods=["GET"])
#@swagger.doc(description='View all features')
def viewFeature():
	sql = SQL_Function()
	rows = sql.select("SELECT Features_ID, Project_ID, Features_Name from features")
	return jsonify(rows)
	#return json.dumps(rows)

@app.route("/featureID", methods=["GET"])
#@swagger.doc(description='View a feature according to its ID')
def viewFeaturePerID():
	# Extract the FeaturesID query parameter from the request
	features_id = request.args.get("FeatureID")

	# Build a SQL query to retrieve the matching feature
	sql = SQL_Function()
	rows = sql.select("SELECT Project_ID, Features_Name from features WHERE Features_ID='"+str(features_id)+"'")
	return jsonify(rows)
	#return json.dumps(rows)

@app.route("/features_projectID", methods=["GET"])
#@swagger.doc(description='View all features under a certain projectID')
def viewFeaturePerProjectID():
	# Extract the FeaturesID query parameter from the request
	project_id = request.args.get("ProjectID")

	# Build a SQL query to retrieve the matching feature
	sql = SQL_Function()
	rows = sql.select("SELECT Features_ID, Features_Name from features WHERE Project_ID ='"+str(project_id)+"'")
	return jsonify(rows)
	#return json.dumps(rows)





if __name__ == "__main__":
	app.run(debug=True, port=8001)