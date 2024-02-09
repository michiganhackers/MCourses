"""
MCoursesFlaskApp index (main) view.

URLs include:
/
"""
import flask
import MCoursesFlaskApp
import requests
import json

ACCESS_TOKEN = ""
TERMS = []
TERM_TO_SCHOOLS_DICT = {}
SCHOOLS_TO_SUBJECTS_DICT = {}

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


def UM_API_get_terms():
    global TERMS
    if TERMS != []:
        return TERMS

    api_url = "https://gw.api.it.umich.edu/um/Curriculum/SOC/Terms"
    headers = {"Authorization": f"Bearer {ACCESS_TOKEN}"}
    response = requests.get(api_url, headers=headers)

    if response.status_code == 401:
        UM_API_set_access_token()
        print("Access token after set call:")
        print(ACCESS_TOKEN)
        response = requests.get(api_url, headers=headers)

    response_dict = response.json()
    print(response_dict)
    TERMS = response_dict["getSOCTermsResponse"]["Term"]
    return TERMS

def UM_API_get_schools_for_term(term_code):
    global TERM_TO_SCHOOLS_DICT
    if TERM_TO_SCHOOLS_DICT.__contains__(term_code):
        return TERM_TO_SCHOOLS_DICT[term_code]
    
    api_url = f"https://gw.api.it.umich.edu/um/Curriculum/SOC/Terms/{term_code}/Schools"
    headers = {"Authorization": f"Bearer {ACCESS_TOKEN}"}
    response = requests.get(api_url, headers=headers)

    if response.status_code == 401:
        UM_API_set_access_token()
        response = requests.get(api_url, headers=headers)


    response_dict = response.json()
    # TERM_TO_SCHOOLS_DICT[term_code] = 

    return response.json()


def UM_API_get_subjects_for_school(term_code, school_code):
    if school_code in SCHOOLS_TO_SUBJECTS_DICT:
        return SCHOOLS_TO_SUBJECTS_DICT[school_code]

    api_url = f"https://gw.api.it.umich.edu/um/Curriculum/SOC/Terms/{term_code}/Schools/{school_code}/Subjects"
    headers = {"Authorization": f"Bearer {ACCESS_TOKEN}"}
    response = requests.get(api_url, headers=headers)

    if response.status_code == 401:
        UM_API_set_access_token()
        response = requests.get(api_url, headers=headers)


    response_dict = response.json()
    print(response_dict)

    SCHOOLS_TO_SUBJECTS_DICT[school_code] = response_dict["getSOCSubjectsResponse"]["Subject"]

    return response.json()


def UM_API_get_catalog_numbers_for_subj(term_code, school_code, subject_code):
    api_url = f"https://gw.api.it.umich.edu/um/Curriculum/SOC/Terms/{term_code}/Schools/{school_code}/Subjects/{subject_code}/CatalogNbrs"
    headers = {"Authorization": f"Bearer {ACCESS_TOKEN}"}
    response = requests.get(api_url, headers=headers)

    if response.status_code == 401:
        UM_API_set_access_token()
        response = requests.get(api_url, headers=headers)

    print(response.json())

    return response.json()


def UM_API_get_description_for_catalog_number(term_code, school_code, subject_code, catalog_number):
    api_url = f"https://gw.api.it.umich.edu/um/Curriculum/SOC/Terms/{term_code}/Schools/{school_code}/Subjects/{subject_code}/CatalogNbrs/{catalog_number}"
    headers = {"Authorization": f"Bearer {ACCESS_TOKEN}"}
    response = requests.get(api_url, headers=headers)

    if response.status_code == 401:
        UM_API_set_access_token()
        response = requests.get(api_url, headers=headers)

    print(response.json())

    return response.json()


def UM_API_get_sections_for_catalog_number(term_code, school_code, subject_code, catalog_number):
    api_url = f"https://gw.api.it.umich.edu/um/Curriculum/SOC/Terms/{term_code}/Schools/{school_code}/Subjects/{subject_code}/CatalogNbrs/{catalog_number}/Sections"
    headers = {"Authorization": f"Bearer {ACCESS_TOKEN}"}
    response = requests.get(api_url, headers=headers)

    if response.status_code == 401:
        UM_API_set_access_token()
        response = requests.get(api_url, headers=headers)

    return response.json()


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
    response_dict = [] # older value? Maybe if (cond): update
    # I figured we may want to call this conditionally and think it's a nice abstraction anyway
    if True:
        response_dict = UM_API_get_terms()

    print(TERMS)

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
    subjects = UM_API_get_subjects_for_school(term_code, school_code)["getSOCSubjectsResponse"]["Subject"]

    return flask.jsonify(subjects)


@MCoursesFlaskApp.app.route('/api/catalog_numbers/<term_code>/<school_code>/<subject_code>', methods=["GET"])
def get_catalog_nums(term_code, school_code, subject_code):
    catalog_nums = UM_API_get_catalog_numbers_for_subj(term_code, school_code, subject_code)["getSOCCtlgNbrsResponse"]["ClassOffered"]

    return flask.jsonify(catalog_nums)


@MCoursesFlaskApp.app.route('/api/catalog_numbers/<term_code>/<school_code>/<subject_code>/<catalog_number>/description', methods=["GET"])
def get_course_desc_for_catalog_num(term_code, school_code, subject_code, catalog_number):
    desc = UM_API_get_description_for_catalog_number(term_code, school_code, subject_code, catalog_number)["getSOCCourseDescrResponse"]["CourseDescr"]

    return flask.jsonify(desc)


@MCoursesFlaskApp.app.route('/api/catalog_numbers/<term_code>/<school_code>/<subject_code>/<catalog_number>/sections', methods=["GET"])
def get_course_sections_for_catalog_num(term_code, school_code, subject_code, catalog_number):
    sections = UM_API_get_sections_for_catalog_number(term_code, school_code, subject_code, catalog_number)["getSOCSectionsResponse"]["Section"]

    return flask.jsonify(sections)


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