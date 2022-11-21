# Service layer

class ServerEnvironment:
    """ Dataclass for specify server environments. """
    production = 'prod'
    development = 'dev'


class HTTPStatusCode:
    OK = 200
    CREATED = 201
    ACCEPTED = 202

    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    METHOD_NOT_ALLOWED = 405
