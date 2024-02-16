
class School:
    
    def __init__(self, api_object):
        self.code = api_object['SchoolCode']
        self.description = api_object['SchoolDescr']
        self.shortcode = api_object['SchoolShortDescr']
    
    def get_code(self) -> str:
        return self.code

    def get_description(self) -> str:
        return self.description

    def get_shortcode(self) -> str:
        return self.shortcode
    
    def to_dict(self) -> dict:
        '''Converts school to a dict'''
        return {
            'code': self.code,
            'description': self.description,
            'shortcode': self.shortcode
        }