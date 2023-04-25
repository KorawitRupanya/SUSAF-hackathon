import mysql.connector
import pandas as pd


class SQL_Function():
	HOSTNAME = "localhost"
	USERNAME = "root"
	PASSWORD = ""
	DATABASE = "susafhackathon"

	def __init__(self):
		# Connect to the database
		self.cnx = mysql.connector.connect(
			host=SQL_Function.HOSTNAME,
			user=SQL_Function.USERNAME,
			password=SQL_Function.PASSWORD,
			database=SQL_Function.DATABASE
		)
		self.cursor = self.cnx.cursor()

	def __del__(self):
		# Close the connection
		self.cursor.close()
		self.cnx.close()

	def insert(self, query, values):
		# Create
		#query = "INSERT INTO table_name (column1, column2, column3) VALUES (%s, %s, %s)"
		#values = ("value1", "value2", "value3")
		self.cursor.execute(query, values)
		self.cnx.commit()

	def select(self, query):
		# Read
		#query = "SELECT * FROM table_name WHERE column1 = 'column1value'"
		self.cursor.execute(query)
		rows = self.cursor.fetchall()
		return rows

	def selectPandas(self, query):
		# Read
		#query = "SELECT * FROM table_name WHERE column1 = 'column1value'"
		self.cursor.execute(query)
		rows = self.cursor.fetchall()
		df = pd.DataFrame(rows) # Create a DataFrame from the query result
		return df

	def update(self, query, values):
		# Update
		#query = "UPDATE table_name SET column2 = %s WHERE column1 = %s"
		#values = ("new_value", "value1")
		self.cursor.execute(query, values)
		self.cnx.commit()

	def update(self, query, values):
		# Delete
		#query = "DELETE FROM table_name WHERE column1 = %s"
		#values = ("value1",)
		self.cursor.execute(query, values)
		self.cnx.commit()

	
