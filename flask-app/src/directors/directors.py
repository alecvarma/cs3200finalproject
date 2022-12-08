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
@directors.route('/applications/actorID>', methods=['POST'])
def get_applications(actorID):
    cursor = db.get_db().cursor()
    #project_id, role_id, actor_id, resume, status
    cursor.execute('select p.title, r.char_name, a.submit_time \
        from application a join role r on a.role_id = r.role_id  \
            join projects p on p.p_id = a.project_id where a.status = "true" and actor_id = {0}'.format(actorID))

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# POST Roles
@directors.route('/applications', methods=['POST'])
def post_application():
    from_page = request.form
    cursor = db.get_db().cursor()
    #project_id, role_id, actor_id, resume, status
    cursor.execute('insert into Role ... ')
    return f"Applied to Role {from_page['char_name']}"

# POST Reviews
@directors.route('/reviews/<actorID>', methods=['POST'])
def get_reviews(actorID):
    cursor = db.get_db().cursor()
    #project_id, role_id, actor_id, resume, status
    cursor.execute('select r.rating, d.first_name, d.last_name, r.description \
        from reviews r join director d on r.dir_id = d.dir_id where actor_id = {0}'.format(actorID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


