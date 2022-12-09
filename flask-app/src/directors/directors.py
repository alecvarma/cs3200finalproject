# Directors:
# POST Roles
# POST Projects
# GET Applications
# POST Reviews

from flask import Blueprint, request, jsonify, make_response
import json
from src import db


directors = Blueprint('directors', __name__)

# GET Applications
@directors.route('/applications/<directorID>', methods=['GET'])
def get_roles(directorID):
    cursor = db.get_db().cursor()
    # status attritube of role is not in the example data
    cursor.execute('SELECT a.resume, a.status, a.submit_time, act.first_name, act.last_name\
        from Director d join Project p on d.dir_id = p.dir_id join Application a on a.projectid = p.p_id join Actor act on act.actor_id = a.actor_id\
            where d.dir_id = {0}'.format(directorID))

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# POST Projects
@directors.route('/projects', methods=['POST'])
def post_projects():
    from_page = request.form
    cursor = db.get_db().cursor()
    cursor.execute('insert into Project (p_id, title, type, cast, country, genre, status, duration, dir_id, proj_release_date) \
        values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)', (from_page["p_id"],from_page["title"],from_page["type"],from_page["cast"], 
        from_page["country"], from_page["genre"], from_page["status"], from_page["duration"], from_page["dir_id"], from_page["proj_release_date"]))
    return "Added to Projects"

# POST Roles
@directors.route('/roles', methods=['POST'])
def post_role():
    from_page = request.form
    cursor = db.get_db().cursor()
    cursor.execute('insert into Role (role_id,projectid,role_type,char_name,description,age_range,gender) \
        values (%s,%s,%s,%s,%s,%s,%s)', (from_page["role_id"],from_page["projectid"],from_page["role_type"],from_page["char_name"], 
        from_page["description"], from_page["age_range"], from_page["gender"]))
    return "Added to Role"

# POST Reviews
@directors.route('/reviews', methods=['POST'])
def post_review():
    from_page = request.form
    cursor = db.get_db().cursor()
    cursor.execute('insert into Reviews (description,rating,actor_id,dir_id) \
        values (%s,%s,%s,%s)', (from_page["description"],from_page["rating"],from_page["actor_id"],from_page["dir_id"]))
    return "Added to Reviews"


# GET Projects
@directors.route('/projects/<dir_id>', methods=['GET'])
def get_projects(dir_id):
    cursor = db.get_db().cursor()
    #project_id, role_id, actor_id, resume, status
    # true = open project
    cursor.execute('SELECT * \
            FROM Project \
            WHERE status = "true" and dir_id = {0}'.format(dir_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# # GET Roles
@directors.route('/roles/<dir_id>', methods=['GET'])
def get_roles_for_director(dir_id):
    cursor = db.get_db().cursor()
    #project_id, role_id, actor_id, resume, status
    cursor.execute('SELECT * \
            FROM Role r join Project p on r.projectid = p.p_id \
            WHERE p.dir_id = {0}'.format(dir_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# GET Reviews
@directors.route('/reviews/<dir_id>', methods=['GET'])
def get_reviews(dir_id):
    cursor = db.get_db().cursor()
    #project_id, role_id, actor_id, resume, status
    cursor.execute('SELECT * \
            FROM Reviews \
            WHERE dir_id = {0}'.format(dir_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

