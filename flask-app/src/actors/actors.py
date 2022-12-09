from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db
from datetime import datetime


actors = Blueprint('actors', __name__)

# Get all customers from the DB
@actors.route('/roles', methods=['GET'])
def get_roles():
    cursor = db.get_db().cursor()
    # status attritube of role is not in the example data
    cursor.execute('select r.role_id,p.title,r.role_type,r.char_name,r.description,r.age_range,r.gender,p.p_id\
        from Role r join Project p on r.projectid = p.p_id')
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
        from Application a join Role r on a.role_id = r.role_id  \
            join Project p on p.p_id = a.projectid where a.status = "true" and actor_id = {0}'.format(actorID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Post application data for a particular role
@actors.route('/applications', methods=['Post'])
def post_application():
    from_page = request.form
    cursor = db.get_db().cursor()
    #projectid, role_id, actor_id, resume, status, submit_time
       # '2022-09-20 10:42:59'
    right_now = datetime.now()
    dt_string = right_now.strftime("%Y-%m-%d %H:%M:%S")
    current_app.logger.info(from_page)
    # current_app.logger.info('insert into Application (projectid, role_id, actor_id, resume, status, submit_time) \
    #     values (%s,%s,%s,%s, true, %s', (from_page["projectId"],from_page["role_id"],from_page["actor_id"],from_page["resume"], dt_string))
    cursor.execute('insert into Application (projectid, role_id, actor_id, resume, status, submit_time) \
        values (%s,%s,%s,%s,true,%s)', (from_page["projectId"],from_page["role_id"],from_page["actor_id"],from_page["resume"], dt_string))
    return f"Applied to Role"

# Get reviews for an actor with a particular actor_id
@actors.route('/reviews/<actorID>', methods=['GET'])
def get_reviews(actorID):
    cursor = db.get_db().cursor()
    #project_id, role_id, actor_id, resume, status
    cursor.execute('select r.rating, d.first_name, d.last_name, r.description \
        from Reviews r join Director d on r.dir_id = d.dir_id where actor_id = {0}'.format(actorID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


