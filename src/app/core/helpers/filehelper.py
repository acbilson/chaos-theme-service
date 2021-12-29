import os
import re
from typing import List

has_backref = re.compile('backref.*src="([a-zA-Z/-]*)"')


def get_backref_files(root_path: str, skipped_dirs=["/logs", "/stones"]) -> List[str]:
    """Returns file paths for every backref-supported file at the root path. Configure to skip directories."""
    paths = []
    for loc in os.walk(root_path):
        root, _, files = loc
        if _should_skip(root, skipped_dirs):
            continue
        for f in files:
            if f.endswith(".md") and not f.startswith("_"):
                paths.append(os.path.join(root, f))
    return paths


def get_backlinks(path: str) -> List[str]:
    with open(path, "r") as f:
        content = f.read()
        matches = has_backref.findall(content)
        return matches


def _should_skip(path: str, skipped_dirs: List[str]) -> bool:
    for skip in skipped_dirs:
        return skip in path


def trim_link(path: str, prefix: str) -> str:
    no_prefix = path[len(prefix) :] if path.startswith(prefix) else path
    return no_prefix.rstrip(".md")
