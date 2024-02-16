
class Term:
    
    def __init__(self, api_object):
        self.code = api_object['TermCode']
        self.description = api_object['TermDescr']
        # converts "WN 2024" to "WN2024"
        self.shortcode = api_object['TermShortDescr']
    
    def get_code(self) -> int:
        return self.code

    def get_description(self) -> str:
        return self.description

    def get_shortcode(self) -> str:
        '''Returns shortcode without whitespace
        
        Example: WN2024'''
        return ''.join(self.shortcode.split(' '))
    
    def get_shortcode_for_api(self) -> str:
        '''Returns the term shortcode as used by the UM API
        
        Example: WN 2024'''
        return self.shortcode
    
    def to_dict(self) -> dict:
        '''Converts term to a dict'''
        return {
            'name': self.description,
            'shortcode': self.get_shortcode(),
            'id': self.code
        }