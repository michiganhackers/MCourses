import sys
import json
import firebase_admin
from firebase_admin import db
from firebase_admin import credentials
from MCoursesFlaskApp.views import index

def get_term_descriptions() -> dict:
    term_descriptions = [term_dict["TermDescr"] for term_dict in index.UM_API_get_terms()]
    return term_descriptions
    

def get_schools(term) -> dict:
    schools = [school_dict["SchoolCode"] for school_dict in index.UM_API_get_schools_for_term(term)]
    return schools


def get_subjects(term, school) -> dict:
    subjects = [subject_dict["SubjectCode"] for subject_dict in index.UM_API_get_subjects_for_school(term, school)]
    return subjects


def get_catalog_nums(term, school, subject) -> dict:
    catalog_nums = [catalog_dict["CatalogNumber"] for catalog_dict in index.UM_API_get_catalog_numbers_for_subj(term, school, subject)]
    return catalog_nums


def get_credits(term, school, subject, catalog_num):
    sections = index.UM_API_get_sections_for_catalog_number(term, school, subject, catalog_num)
    if sections and isinstance(sections, list):
        return sections[0]["CreditHours"]
    else:
        return sections["CreditHours"]


def get_description(term, school, subject, catalog_num):
    descriptions = index.UM_API_get_description_for_catalog_number(term, school, subject, catalog_num)
    return descriptions

def get_long_name(term, school, subject, catalog_num) :
    descriptions = get_description(term, school, subject, catalog_num)

    return descriptions.partition(" --- ")[0]

def create_entry(term, school, subject, catalog):
    name = get_long_name(term, school, subject, catalog)
    description = get_description(term, school, subject, catalog)
    credits = get_credits(term, school, subject, catalog)
    
    courseDict = {
        "name": name, # Video game development
        "description": description,
        "credits": credits,
        "school": school, # ENG
        "subject": subject, # EECS
        "catalog_number": catalog # 494
        #"instructor": 'test'
    }

    return courseDict


def main():
    # TODO
    # Fetch the service account key JSON file contents
    # cred = credentials.Certificate('path/to/serviceAccountKey.json')

    # TODO
    # Initialize the app with a service account, granting admin privileges
    # firebase_admin.initialize_app(cred, {
    #     'databaseURL': 'https://databaseName.firebaseio.com'
    # })

    printMode = True
    # ref = db.reference("/")

    index.UM_API_set_access_token()
    term = "2470"

    term_desc = get_term_descriptions()
    print(term_desc)
    # @ Optional term input
    if (len(sys.argv) == 2):
        term = str(sys.argv[1])

    schools = get_schools("2470")

    for school in schools:
        subjects = get_subjects(term, school)
        
        for subject in subjects:
            catalog_nums = get_catalog_nums(term, school, subject)

            for catalog in catalog_nums:
                courseDict = create_entry(term, school, subject, catalog)

                if printMode:
                    print()
                    for key, val in courseDict.items():
                        print(f"{key}: {val}")
                    print()
                else:
                    jsonObj = json.dumps(courseDict)
                    ref.set(jsonObj)




if __name__ == "__main__":
    main()


