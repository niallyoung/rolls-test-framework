import os
import logging
import subprocess
import sys
from unittest import TestCase

logger = logging.getLogger(__name__)


class TestRolls(TestCase):

    def setUp(self) -> None:
        self.project_root = _get_env('PROJECT_ROOT')
        return


    # TODO execute python/src/rolls.py with a list of known inputs, validated output against fixtures
    def test_fixtures(self):
        for filename in os.listdir(self.project_root + "/fixtures/input"):
            f = os.path.join(self.project_root, "fixtures/input", filename)
            if os.path.isfile(f):
                command = "source {}/.venv/bin/activate && cat {} | python {}/python/src/rolls.py".format(self.project_root, f, self.project_root)
                res = subprocess.check_output(command, shell=True)
                output_file = self.project_root + "/fixtures/output/" + filename
                with open(output_file) as o:
                    text = o.read()
                    sys.stderr.write(text)
                    self.assertEqual(res.decode("utf-8"), text)

def _get_env(key):
    value = os.getenv(key)
    if value is None:
        raise EnvironmentError('unable to find {} in ENV'.format(key))
    return value