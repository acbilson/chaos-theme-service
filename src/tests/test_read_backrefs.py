import unittest
from unittest import mock
from unittest.mock import Mock
from app.config import TestConfig
from base_test import BaseTest


class ReadBackrefTests(BaseTest):
    def test_read_backrefs(self):

        resp = self.client.get("/backrefs")
        self.assertEqual(resp.status, "200 OK")
        body = resp.get_json()
        self.assertGreater(len(body), 0)
        self.assertTrue("lastrun" in body and "results" in body)
        self.assertGreater(len(body["results"]), 0)


if __name__ == "__main__":
    unittest.main()
