class Course:
    # referred to by UM API as "catalog number", but course makes more sense here

    def __init__(self, api_object: dict, subject_code: str):
        self.subject_code = subject_code
        self.catalog_number = api_object['CatalogNumber']
        self.description = api_object['CourseDescr']
    
    def get_subject_code(self) -> str:
        return self.subject_code
      
    def get_catalog_number(self) -> str:
        return self.catalog_number
    
    def get_course_name(self) -> str:
        return f'{self.subject_code} {self.catalog_number}'
    
    def get_course_description(self) -> str:
        return self.description
    
    def get_course_full_name(self) -> str:
        course_name = self.get_course_full_name()
        return f'{course_name}: {self.description}'