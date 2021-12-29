import unittest
from app.core.helpers import filehelper


class FilehelperTests(unittest.TestCase):
    def test_get_backref_files(self):
        files = filehelper.get_backref_files("/mnt/chaos/content")
        self.assertGreater(len(files), 0)

    def test_get_backlinks(self):
        backlinks = filehelper.get_backlinks(
            "/mnt/chaos/content/gardens/business/business-insights.md"
        )
        self.assertGreater(len(backlinks), 0)


if __name__ == "__main__":
    unittest.main()
