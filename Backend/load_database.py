import sys
import requests
from MCoursesFlaskApp.views import index

def get_schools(term) -> dict:
    schools = [school_dict["SchoolCode"] for school_dict in index.UM_API_get_schools_for_term(term)]
    return schools


def get_subjects(term, school):
    subjects = [subject_dict["SubjectCode"] for subject_dict in index.UM_API_get_subjects_for_school(term, school)]
    return subjects


def get_catalog_nums(term, school, subject):
    catalog_nums = [catalog_dict["CatalogNum"] for catalog_dict in index.UM_API_get_catalog_numbers_for_subj(term, school, subject)]
    return catalog_nums


def get_description(term, school, subject, catalog_num):
    #descriptions = [descriptions_dict["Description"] for descriptions_dict in index.]
    return ""


def main():
    term = "2470"

    # @ Optional term input
    if (len(sys.argv) == 2):
        term = str(sys.argv[1])

    schools = get_schools(term)

    for school in schools:
        subjects = get_subjects(term, school)
        
        for subject in subjects:
            catalog_nums = get_catalog_nums(term, school, subject)

            for catalog in catalog_nums:
                description = get_description(term, school, subject, catalog)
                print(description)




if __name__ == "__main__":
    main()


