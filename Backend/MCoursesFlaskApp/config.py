"""MCoursesFlaskApp development configuration."""

import pathlib

# Root of this application, useful if it doesn't occupy an entire domain
APPLICATION_ROOT = '/'

# & Probably not needed for now
# Secret key for encrypting cookies
SECRET_KEY = b'FIXME SET WITH: $ python3 -c "import os; print(os.urandom(24))" '
SESSION_COOKIE_NAME = 'login'

# & Probably not needed for now
# File Upload to var/uploads/
INSTA485_ROOT = pathlib.Path(__file__).resolve().parent.parent
UPLOAD_FOLDER = INSTA485_ROOT/'var'/'uploads'
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])
MAX_CONTENT_LENGTH = 16 * 1024 * 1024

# TODO: Change later
# Database file is var/insta485.sqlite3
DATABASE_FILENAME = INSTA485_ROOT/'var'/'insta485.sqlite3'

