import sys
import json
import firebase_admin
from firebase_admin import credentials, firestore
from MCoursesFlaskApp.views import index
from MCoursesFlaskApp.secrets import DATABASE_URL

def get_term_descriptions() -> dict:
    term_descriptions = []
    term_dicts = index.UM_API_get_terms()

    for term_dict in term_dicts:
        if isinstance(term_dict, dict):
            if "TermDescr" in term_dict:
                term_descriptions.append(term_dict["TermDescr"])
            else:
                print("Missing key 'TermDescr' in dictionary:", term_dict)
        else:
            print("Non-dictionary item encountered in term description:", term_dict)
        
    return term_descriptions
    

def get_schools(term) -> dict:
    schools = []
    school_dicts = index.UM_API_get_schools_for_term(term)

    for school_dict in school_dicts:
        if isinstance(school_dict, dict):
            if "SchoolCode" in school_dict:
                schools.append(school_dict["SchoolCode"])
            else:
                print("Missing key 'SchoolCode' in dictionary:", school_dict)
        else:
            print("Non-dictionary item encountered in school:", school_dict)
        
    return schools


def get_subjects(term, school) -> dict:
    subjects = []
    subject_dicts = index.UM_API_get_subjects_for_school(term, school)

    for subject_dict in subject_dicts:
        if isinstance(subject_dict, dict):
            if "SubjectCode" in subject_dict:
                subjects.append(subject_dict["SubjectCode"])
            else:
                print("Missing key 'SubjectCode' in dictionary:", subject_dict)
        else:
            print("Non-dictionary item encountered in subject:", subject_dict)
        
    return subjects


def get_catalog_nums(term, school, subject) -> dict:
    catalog_nums = []
    catalog_dicts = index.UM_API_get_catalog_numbers_for_subj(term, school, subject)

    for catalog_dict in catalog_dicts:
        if isinstance(catalog_dict, dict):
            if "CatalogNumber" in catalog_dict:
                catalog_nums.append(catalog_dict["CatalogNumber"])
            else:
                print("Missing key 'CatalogNumber' in dictionary:", catalog_dict)
        else:
            print("Non-dictionary item encountered in catalog:", catalog_dict)

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
        "catalog_number": catalog, # 494
        "avg_rating": -1.0, 
        "avg_workload": -1.0,
        "avg_worth": -1.0,
        "avg_enjoyment": -1.0,
        "num_reviews": 0
        #"instructor": 'test'
    }

    return courseDict

def testDB(db):
    tempDict = {
        "test1": "val1",
        "test2": "12",
    }
    db.collection("classes").document(" ").set(tempDict)
    
    exit()


def main():
    # TODO
    # Fetch the service account key JSON file contents
    cred = credentials.Certificate('MCoursesFlaskApp/serviceAccountKey.json')

    # TODO
    # Initialize the app with a service account, granting admin privileges
    firebase_admin.initialize_app(cred, {
         'databaseURL': DATABASE_URL
    })
    printMode = False

    db = firestore.client()
    
    # testDB(db)

    index.UM_API_set_access_token()
    term = "2470"

    term_desc = get_term_descriptions()
    #print(term_desc)
    # @ Optional term input
    if (len(sys.argv) == 2):
        term = str(sys.argv[1])

    schools = get_schools("2470")


    for i, school in enumerate(schools):

        print(f"School {i}/{len(schools)}")
        subjects = get_subjects(term, school)

        for j, subject in enumerate(subjects):

            print(f"\tSubject {j}/{len(subjects)}")
            catalog_nums = get_catalog_nums(term, school, subject)
            print(f"\t\t{len(catalog_nums)} courses")
            for catalog in catalog_nums:
                
                courseDict = create_entry(term, school, subject, catalog)

                if printMode:
                    print()
                    for key, val in courseDict.items():
                        print(f"{key}: {val}")
                        print()
                else:
                    db.collection("classes").document(f"{courseDict['subject']}_{courseDict['catalog_number']}").set(courseDict)
                    




if __name__ == "__main__":
    main()


