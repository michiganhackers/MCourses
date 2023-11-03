"""
MCoursesFlaskApp index (main) view.

URLs include:
/
"""
import flask
import MCoursesFlaskApp

# flask --app MCoursesFlaskApp --debug run --host 0.0.0.0 --port 8000


@MCoursesFlaskApp.app.route('/api/', methods=["GET"])
def get_services():
    """Return a list of services available."""
    context = {
        "courses": "/api/courses/",
        "url": "/api/"
    }
    return flask.jsonify(**context)


# In-progress
@MCoursesFlaskApp.app.route('/api/courses/', methods=["GET"])
def get_courses():
    """Return a list of all current courses."""
    
    # TODO: Need to make UM API call
    courses = []

    # Clean list

    context = {
        "courses": courses
    }

    return flask.jsonify(**context)


@MCoursesFlaskApp.app.route('/api/courses/<course_id>', methods=["GET"])
def get_course_id(course_id: int):
    """Return a list of all current courses."""

    # Get from DB
    user_reviews = [
        {
            "user_id": 1,
            "rating": 4.5,
            "comments": "I liked the professor a lot!"
        },
        {
            "user_id": 2,
            "rating": 3,
            "comments": "Prof. Smith was crazy"
        }
    ]

    context = {
        "course_id": course_id,
        "number_of_seats_open": int(course_id) * 25,
        "user_reviews": user_reviews
    }

    return flask.jsonify(**context)