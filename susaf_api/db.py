# db.py
import os
import pymysql
from flask import jsonify

db_user = os.environ.get("CLOUD_SQL_USERNAME")
db_password = os.environ.get("CLOUD_SQL_PASSWORD")
db_name = os.environ.get("CLOUD_SQL_DATABASE_NAME")
db_connection_name = os.environ.get("CLOUD_SQL_CONNECTION_NAME")


def open_connection():
    unix_socket = "/cloudsql/{}".format(db_connection_name)
    try:
        # if os.environ.get('GAE_ENV') == 'standard':
        conn = pymysql.connect(
            user=db_user,
            password=db_password,
            unix_socket=unix_socket,
            db=db_name,
            cursorclass=pymysql.cursors.DictCursor,
        )
        print("here")
        return conn
    except pymysql.MySQLError as e:
        print(e)


# PROJECT
def get_projects():
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM projects;")
        projects = cursor.fetchall()
    conn.close()
    return jsonify(projects)


def get_project_by_id(id):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM projects WHERE id=%s;", id)
        project = cursor.fetchone()
    conn.close()
    return jsonify(project)


def add_project(project):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute(
            "INSERT INTO projects (title, description) VALUES(%s, %s)",
            (project["title"], project["description"]),
        )
        conn.commit()
        conn.close()
        return cursor.lastrowid


# FEATURE
def get_features_by_project_id(project_id):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM features WHERE project_id=%s;", project_id)
        features = cursor.fetchall()
    conn.close()
    return jsonify(features)


def get_feature_by_id(id):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM features WHERE id=%s;", id)
        project = cursor.fetchone()
    conn.close()
    return jsonify(project)


def add_feature(feature):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute(
            "INSERT INTO features (name, project_id) VALUES(%s, %s)",
            (feature["name"], feature["project_id"]),
        )
        conn.commit()
        conn.close()
        return cursor.lastrowid


# QUESTION
def get_questions_by_dimension(dimension):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM questions WHERE dimension=%s;", dimension)
        questions = cursor.fetchall()
    conn.close()
    return jsonify(questions)


# ANSWER
def get_answers_by_feature_id_dimension(feature_id, dimension):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute(
            """SELECT *
                        FROM answers LEFT JOIN questions
                        ON answers.question_id = questions.id
                        WHERE answers.feature_id = %s AND questions.dimension = %s;""",
            (feature_id, dimension),
        )
        answers = cursor.fetchall()
    conn.close()
    return jsonify(answers)


def get_answers_by_feature_id_dimension_chatgpt(feature_id, dimension):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute(
            """SELECT answers.answer_text
                        FROM answers LEFT JOIN questions
                        ON answers.question_id = questions.id
                        WHERE answers.feature_id = %s AND questions.dimension = %s;""",
            (feature_id, dimension),
        )
        answers = cursor.fetchall()
    conn.close()
    return answers


def add_answer(answer):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute(
            "INSERT INTO answers (answer_text, chatgpt, is_edited, feature_id, question_id) VALUES(%s, %s, %s, %s, %s)",
            (
                answer["answer_text"],
                answer["chatgpt"],
                answer["is_edited"],
                answer["feature_id"],
                answer["question_id"],
            ),
        )
        conn.commit()
        conn.close()
        return cursor.lastrowid


def add_impact(feature_id, dimension, impact_text):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute(
            "INSERT INTO impacts (impact_text, feature_id, dimension) VALUES(%s, %s, %s)",
            (
                impact_text,
                feature_id,
                dimension,
            ),
        )
        conn.commit()
        conn.close()
        return cursor.lastrowid


def get_impacts_by_feature_id_dimension(feature_id, dimension):
    conn = open_connection()
    with conn.cursor() as cursor:
        cursor.execute(
            """SELECT * FROM impacts
                WHERE feature_id = %s AND dimension = %s;""",
            (feature_id, dimension),
        )
        impacts = cursor.fetchall()
    conn.close()
    return impacts
