try:
    from app import app
    import unittest
    import pytest

except Exception as e:
    print('modules are missing {} '.format(e))

class flasktest(unittest.TestCase):

    def test_2_index(self):
        tester = app.test_client(self)
        response = tester.get('/')
        statuscode = response.status_code
        self.assertEqual(statuscode,200)
    
