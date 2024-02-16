
class Section:
    '''Only contains basic information about a Section object
    
    For full reference see:
    https://dir.api.it.umich.edu/docs/umscheduleofclasses/1/routes/Terms/%7BTermCode%7D/Schools/%7BSchoolCode%7D/Subjects/%7BSubjectCode%7D/CatalogNbrs/%7BCatalogNumber%7D/Sections/%7BSectionNumber%7D/get
    '''

    def __init__(self, term_code: int, school: str, subject_code: str, catalog_number: str, section_number: str, api_object: dict):
        '''Example:
        
        Section(2470, 'ENG', 'EECS', '280', '001', {.. object from api ..})'''

        # todo: cleanup the constructor
        self.term_code = term_code
        self.school = school
        self.subject_code = subject_code
        self.catalog_number = catalog_number
        self.section_number = section_number
        # we are going to store the original api object for extensibility as well
        self.um_api_object = api_object
        self.section_type = api_object['SectionType']
        self.section_type_description = api_object['SectionTypeDescr']
        self.class_number = api_object['ClassNumber']
        self.course_description = api_object['CourseDescr']
    
    def get_class_name(self) -> str:
        '''Returns the class name of this section
        
        Example: "EECS 280"'''
        return f'{self.subject_code} {self.catalog_number}'
    
    def get_class_fullname(self) -> str:
        '''Returns the complete class name
        
        Example: "EECS 280: Prog&Data Struct"'''
        class_name = self.get_class_name()
        return f'{class_name}: {self.course_description}'
    
    def get_section_name(self) -> str:
        '''Returns the section name with the course
        
        Example: "EECS 280-001"'''
        class_name = self.get_class_name()
        return f'{class_name}-{self.section_number}'
    
    def get_section_full_name(self) -> str:
        '''Returns the section name with the section's description
        
        Example: "EECS 280-001 (Lecture)'''
        section_name = self.get_section_name()
        return f'{section_name}: {self.section_type_description}'
