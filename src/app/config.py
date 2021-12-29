from os import environ


class BaseConfig(object):
    """Set Flask configuration variables"""

    FLASK_ENV = environ.get("FLASK_ENV")
    CONTENT_PATH = "/mnt/chaos/content"

    FLASK_SECRET_KEY = environ.get("FLASK_SECRET_KEY")


class TestConfig(object):
    """Set Flask test configuration variables"""

    FLASK_ENV = "development"
    CONTENT_PATH = "/mnt/chaos/content"

    FLASK_SECRET_KEY = "my secret test key"
