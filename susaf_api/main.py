# main.py
from flask import Flask, jsonify, request
from flask_cors import CORS

from db import *

import openai

app = Flask(__name__)
CORS(app)

OPENAI_KEY = os.environ.get("OPENAI_KEY")


@app.route("/")
def home():
    return "Hello World"


@app.route("/projects", methods=["POST", "GET"])
def projects():
    if request.method == "POST":
        project_id = add_project(request.get_json())
        return jsonify({"id": project_id})
    else:
        if "id" in request.args:
            id = request.args.get("id")
            return get_project_by_id(id)
        else:
            return get_projects()


@app.route("/features", methods=["POST", "GET"])
def features():
    if request.method == "POST":
        feature_id = add_feature(request.get_json())
        return jsonify({"id": feature_id})
    else:
        if "project_id" in request.args:
            project_id = request.args.get("project_id")
            return get_features_by_project_id(project_id)
        elif "id" in request.args:
            id = request.args.get("id")
            return get_feature_by_id(id)


@app.route("/questions", methods=["GET"])
def questions():
    dimension = request.args.get("dimension")
    return get_questions_by_dimension(dimension)


@app.route("/answers", methods=["POST", "GET"])
def answers():
    if request.method == "POST":
        answer_id = add_answer(request.get_json())
        return jsonify({"id": answer_id})
    else:
        feature_id = request.args.get("feature_id")
        dimension = request.args.get("dimension")
        return get_answers_by_feature_id_dimension(feature_id, dimension)


@app.route("/answer-suggestion", methods=["POST"])
def suggestAnswers():
    req_data = request.get_json()
    prompt = req_data.get("prompt")

    print(prompt)
    # Define OpenAI API key
    openai.api_key = OPENAI_KEY

    # Set up the model and prompt
    model_engine = "text-davinci-003"

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
    return jsonify(response)


@app.route("/impact-generation", methods=["GET"])
def generateImpacts():
    prompt = ""
    feature_id = request.args.get("feature_id")
    dimension = request.args.get("dimension")
    answers = get_answers_by_feature_id_dimension_chatgpt(feature_id, dimension)
    for answer in answers:
        prompt += str(answer) + "\n"

    prompt += str.format(
        "\nIdentify 1-5 impacts in the {} dimension of sustainability from the given text. The impacts should be short, not more than 5 words. Use only newline character as separator between the impacts.",
        dimension,
    )

    print(prompt)
    # Define OpenAI API key
    openai.api_key = OPENAI_KEY

    # Set up the model and prompt
    model_engine = "text-davinci-003"

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
    impacts = response.strip().split('\n')
    for impact in impacts:
        add_impact(feature_id, dimension, impact)
    return jsonify(impacts)


if __name__ == "__main__":
    app.run(debug=True)
