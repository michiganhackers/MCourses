"""
MCoursesFlaskApp index (main) view.

URLs include:
/
"""
import flask
import MCoursesFlaskApp
import MCoursesFlaskApp.models as models
import requests
import json

API_BASE_URL = 'https://gw.api.it.umich.edu/um/Curriculum/SOC'
ACCESS_TOKEN = ""

# flask --app MCoursesFlaskApp --debug run --host 0.0.0.0 --port 8000

def UM_API_set_access_token():
    print("Set access token called")
    api_url = "https://gw.api.it.umich.edu/um/oauth2/token"
    headers = {"content-type": "application/x-www-form-urlencoded"}
    data = {
        'grant_type': 'client_credentials',
        'client_id': '',  # CLIENT_KEY
        'client_secret': '',  # CLIENT_SECRET
        'scope': 'umscheduleofclasses'  # umscheduleofclasses
    }

    response = requests.post(api_url, headers=headers, data=data)
    response_dict = response.json()

    global ACCESS_TOKEN 
    ACCESS_TOKEN = response_dict["access_token"]
    print(ACCESS_TOKEN)

    print(response.json())
    return response


def UM_API_get_url(path):
    api_url = API_BASE_URL + path
    headers = {"Authorization": f"Bearer {ACCESS_TOKEN}"}
    response = requests.get(api_url, headers=headers)

    if response.status_code == 401:
        UM_API_set_access_token()
        response = requests.get(api_url, headers=headers)

    return response.json()


def UM_API_get_terms():
    path = "/Terms"
    response_dict = UM_API_get_url(path)

    return response_dict["getSOCTermsResponse"]["Term"]

def UM_API_get_modeled_terms() -> models.Term:
    path = "/Terms"
    response_dict = UM_API_get_url(path)

    return models.Term(response_dict["getSOCTermsResponse"]["Term"])

def UM_API_get_schools_for_term(term_code):
    path = f"/Terms/{term_code}/Schools"
    response_dict = UM_API_get_url(path)

    return response_dict["getSOCSchoolsResponse"]["School"]

def UM_API_get_schools_for_term_modeled(term: models.Term) -> models.School:
    path = f'/Terms/{term.get_code()}/Schools'
    response_dict = UM_API_get_url(path)
    return [models.School(school) for school in response_dict["getSOCSchoolsResponse"]["School"]]


def UM_API_get_subjects_for_school(term_code, school_code):
    path = f"/Terms/{term_code}/Schools/{school_code}/Subjects"
    response_dict = UM_API_get_url(path)

    return response_dict["getSOCSubjectsResponse"]["Subject"]


def UM_API_get_catalog_numbers_for_subj(term_code, school_code, subject_code):
    path = f"/Terms/{term_code}/Schools/{school_code}/Subjects/{subject_code}/CatalogNbrs"
    response_dict = UM_API_get_url(path)

    return response_dict["getSOCCtlgNbrsResponse"]["ClassOffered"]


def UM_API_get_description_for_catalog_number(term_code, school_code, subject_code, catalog_number):
    path = f"/Terms/{term_code}/Schools/{school_code}/Subjects/{subject_code}/CatalogNbrs/{catalog_number}"
    response_dict = UM_API_get_url(path)

    return response_dict["getSOCCourseDescrResponse"]["CourseDescr"]


def UM_API_get_sections_for_catalog_number(term_code, school_code, subject_code, catalog_number):
    path = f"/Terms/{term_code}/Schools/{school_code}/Subjects/{subject_code}/CatalogNbrs/{catalog_number}/Sections"

    response_dict = UM_API_get_url(path)

    return response_dict["getSOCSectionsResponse"]["Section"]

def UM_API_get_section_details(term_code, school_code, subject_code, catalog_number, section_number):
    path = f"/Terms/{term_code}/Schools/{school_code}/Subjects/{subject_code}/CatalogNbrs/{catalog_number}/Sections/{section_number}"

    response_dict = UM_API_get_url(path)

    return response_dict["getSOCSectionDetailResponse"]


@MCoursesFlaskApp.app.route('/', methods=["GET"])
def empty_route():
    UM_API_set_access_token()
    return get_services()


@MCoursesFlaskApp.app.route('/api/', methods=["GET"])
def get_services():
    """Return a list of services available."""
    context = {
        "url": "/api/",
        "courses": "/api/courses/",
        "terms": "/api/terms/",
        "schools": "/api/schools/<term_code>",
        "courseID": "/api/courses/<course_id> (test with course_id=12)",
        "subjects": '/api/subjects/<term_code>/<school_code>',
        "catalog numbers": "/api/catalog_numbers/<term_code>/<school_code>/<subject_code>",
        "course description": "/api/catalog_numbers/<term_code>/<school_code>/<subject_code>/<catalog_number>/description",
        "section numbers": "/api/catalog_numbers/<term_code>/<school_code>/<subject_code>/<catalog_number>/sections",
        "section details": "/api/section/<term_code>/<school_code>/<subject_code>/<catalog_number>/<section_number>",
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


@MCoursesFlaskApp.app.route('/api/terms/', methods=["GET"])
def get_terms():
    """Return a list of all terms."""
    response_dict = UM_API_get_terms()

    return flask.jsonify(response_dict)


@MCoursesFlaskApp.app.route('/api/schools/<term_code>', methods=["GET"])
def get_schools(term_code):
    # * atm, written for most recent term
    # terms = UM_API_get_terms()
    # schools = UM_API_get_schools_for_term(terms["TermCode"])
    schools = UM_API_get_schools_for_term(term_code)

    return flask.jsonify(schools)


@MCoursesFlaskApp.app.route('/api/subjects/<term_code>/<school_code>', methods=["GET"])
def get_subjects(term_code: str, school_code: str):
    subjects = UM_API_get_subjects_for_school(term_code, school_code)

    return flask.jsonify(subjects)


@MCoursesFlaskApp.app.route('/api/catalog_numbers/<term_code>/<school_code>/<subject_code>', methods=["GET"])
def get_catalog_nums(term_code, school_code, subject_code):
    catalog_nums = UM_API_get_catalog_numbers_for_subj(term_code, school_code, subject_code)

    return flask.jsonify(catalog_nums)


@MCoursesFlaskApp.app.route('/api/catalog_numbers/<term_code>/<school_code>/<subject_code>/<catalog_number>/description', methods=["GET"])
def get_course_desc_for_catalog_num(term_code, school_code, subject_code, catalog_number):
    desc = UM_API_get_description_for_catalog_number(term_code, school_code, subject_code, catalog_number)

    return flask.jsonify(desc)


@MCoursesFlaskApp.app.route('/api/catalog_numbers/<term_code>/<school_code>/<subject_code>/<catalog_number>/sections', methods=["GET"])
def get_course_sections_for_catalog_num(term_code, school_code, subject_code, catalog_number):
    sections = UM_API_get_sections_for_catalog_number(term_code, school_code, subject_code, catalog_number)

    return flask.jsonify(sections)


@MCoursesFlaskApp.app.route('/api/section/<term_code>/<school_code>/<subject_code>/<catalog_number>/<section_number>', methods=["GET"])
def get_course_section_details(term_code, school_code, subject_code, catalog_number, section_number):
    section = UM_API_get_section_details(term_code, school_code, subject_code, catalog_number, section_number)

    return flask.jsonify(section)


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


@MCoursesFlaskApp.app.route('/api/test/', methods=["GET"])
def test():
    response = UM_API_set_access_token()

    return flask.jsonify()


@MCoursesFlaskApp.app.route('/api/debug_test_model')
def debug_test_model():
    terms = UM_API_get_modeled_terms()
    schools = UM_API_get_schools_for_term_modeled(terms)

    return flask.jsonify({
        'term': terms.to_dict(),
        'schools': [school.to_dict() for school in schools]
    })