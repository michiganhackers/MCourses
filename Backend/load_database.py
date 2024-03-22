import sys
import requests
from MCoursesFlaskApp.views import index

def get_schools(term) -> dict:
    schools = [school_dict["SchoolCode"] for school_dict in index.UM_API_get_schools_for_term(term)]
    return schools


def get_subjects(term, school):
    return []


def get_catalog_nums(term, school, subject):
    return []


def get_description(term, school, subject, catalog_num):
    return ""


def main():
    term = "2470"

    # @ Optional term input
    if (len(sys.argv) == 2):
        term = str(sys.argv[1])

    schools = get_schools(term)

    for school in schools:
        subjects = get_subjects(term, school)
        
        for subject in subjects():
            print()




if __name__ == "__main__":
    main()


