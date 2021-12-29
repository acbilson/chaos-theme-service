import re
import os
from datetime import datetime

from flask import request, jsonify, current_app as app

from ..core import core_bp
from ..core.helpers import filehelper


@core_bp.route("/backrefs", methods=["GET"])
def read_backrefs():

    content_path = app.config.get("CONTENT_PATH")
    last_run = datetime.now()
    results = {}

    backref_files = filehelper.get_backref_files(content_path)

    for backref in backref_files:
        backref_link = filehelper.trim_link(backref, content_path)
        backlinks = filehelper.get_backlinks(backref)

        for link in backlinks:
            if link in results:
                results[link].append(backref_link)
            else:
                results[link] = [backref_link]

    response = dict(lastrun=last_run, results=results)

    return jsonify(response)
