from flask import Blueprint, request, jsonify, make_response
import json
from src import db


admins = Blueprint('admins', __name__)

# Get all the products from the database
@admins.route('/actors', methods=['GET'])
def get_actors():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('select actor_id,first_name,last_name,DATE_FORMAT(DOB, "%Y-%m-%d") AS DOB , admin_id from Actor')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# get the top 5 products from the database
@admins.route('/actors', methods=['Post'])
def post_new_actor():
    from_page = request.form
    cursor = db.get_db().cursor()
    query = '''
        INSERT INTO ACTOR (first_name,last_name,DOB, admin_id)
        values (%s, %s %s, %s)
    '''
    cursor.execute(query, (from_page['f_name'], from_page['l_name'], from_page['dob'], from_page['admin_id']))

    return f'Actor: {from_page["f_name"]} {from_page["l_name"]} added by Admin Id : {from_page["admin_id"]}'