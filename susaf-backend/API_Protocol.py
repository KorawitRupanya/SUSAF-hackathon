from flask import Flask, request
from datetime import datetime, timedelta
from SQL_Function import SQL_Function
from datetime import datetime, timedelta
import json
import openai

app = Flask(__name__)

@app.route("/questions", methods=["GET"])
def questionList():
	sql = SQL_Function()
	rows = sql.select("SELECT * from questions")

	return json.dumps(rows)


@app.route("/answer", methods=["POST"])
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


@app.route("/promptGPT", methods=["POST"])
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
	return response


@app.route("/projectID", methods=["POST"])
def createProject():
	req_data = request.get_json()
	Project_ID = req_data.get("Project_ID")
	owner = req_data.get("owner")

	sql_func = SQL_Function()
	query = "INSERT INTO projects(Project_ID, owner) VALUES (%s, %s)"
	values = (Project_ID, owner)
	sql_func.insert(query, values)
	return {"pushResult": "OK"}


@app.route("/projectID", methods=["GET"])
def viewProject():
	sql = SQL_Function()
	rows = sql.select("SELECT * from projects")
	return json.dumps(rows)




@app.route("/featureID", methods=["POST"])
def createFeature():
	req_data = request.get_json()
	Features_ID = req_data.get("Features_ID")
	Project_ID = req_data.get("Project_ID")

	sql_func = SQL_Function()
	query = "INSERT INTO features(Features_ID, Project_ID) VALUES (%s, %s)"
	values = (Features_ID, Project_ID)
	sql_func.insert(query, values)
	return {"pushResult": "OK"}


@app.route("/featureID", methods=["GET"])
def viewFeature():
	sql = SQL_Function()
	rows = sql.select("SELECT * from features")
	return json.dumps(rows)





if __name__ == "__main__":
	#print (control_tuya("SystemDeviceID", "GETDEVICEINFO", False))
	app.run(debug=True, port=8001)
	#control_tuya("SystemDeviceID", "GETDEVICEINFO", False)