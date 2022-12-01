from flask import Blueprint, request, jsonify, make_response
import json
from src import db


actors = Blueprint('actors', __name__)

# Get all customers from the DB
@actors.route('/roles', methods=['GET'])
def get_roles():
    cursor = db.get_db().cursor()
    # status attritube of role is not in the example data
    cursor.execute('select r.role_id,p.title,r.role_type,r.char_name,r.description,r.age_range,r.gender,\
        from role r join projects p on r.projectid = p.p_id')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get application details for actor with particular actor_id
@actors.route('/applications/<actorID>', methods=['GET'])
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

# Get application details for actor with particular actor_id
@actors.route('/applications', methods=['Post'])
def post_application():
    from_page = request.form
    cursor = db.get_db().cursor()
    #project_id, role_id, actor_id, resume, status
    cursor.execute('insert into Role ... ')
    return f"Applied to Role {from_page['char_name']}"
