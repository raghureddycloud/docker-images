import os
import flask
import datetime 
import socket


def _hello():
    return "Gunicorn Poc with Flasktesting"

def _hostname():
    x = socket.gethostname()
    return x

def build_app():
    """Build a flask app and route endpoints."""
    app.route("/hello")(_hello)
    app.route("/hostname")(_hostname)
    return app

