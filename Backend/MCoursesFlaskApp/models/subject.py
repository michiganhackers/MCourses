
class Subject:
    
    def __init__(self, api_object):
        self.code = api_object['SubjectCode']
        self.description = api_object['SubjectDescr']
    
    def get_code(self) -> str:
        return self.code

    def get_name(self) -> str:
        return self.description

    def get_shortcode(self) -> str:
        # will return same as get code since codes don't have spaces
        return self.code