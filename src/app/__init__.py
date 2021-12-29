from flask import Flask, Response
from app.core import core_bp
from app import config


def create_app(config=config.BaseConfig):
    """Initialize the core application"""
    app = Flask(__name__, instance_relative_config=False)
    app.config.from_object(config)

    # required to encrypt session
    app.secret_key = app.config["FLASK_SECRET_KEY"]

    with app.app_context():

        # register blueprints
        app.register_blueprint(core_bp)

        @app.route("/healthcheck", methods=["GET"])
        def health():
            return Response(status=200)

        return app
