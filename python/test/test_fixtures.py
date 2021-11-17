import os
import logging
import subprocess
from unittest import TestCase

logger = logging.getLogger(__name__)


class TestFixtures(TestCase):

    def setUp(self) -> None:
        self.project_root = _get_env('PROJECT_ROOT')
        return


    def test_fixtures(self):
        for input_filename in os.listdir(self.project_root + "/fixtures/input"):
            i = os.path.join(self.project_root, "fixtures/input", input_filename)
            if os.path.isfile(i):
                command = "source {}/.venv/bin/activate && cat {} | python {}/python/src/rolls.py".format(self.project_root, i, self.project_root)
                fresh_seed = subprocess.check_output(command, shell=True)
                output_filename = self.project_root + "/fixtures/output/" + input_filename
                with open(output_filename) as o:
                    known_seed = o.read()
                    print("generating fresh-seed from {} and compared to known-seed fixture {}".format(i, output_filename))
                    self.assertEqual(fresh_seed.decode("utf-8"), known_seed)
                    # TODO easy way to force this to show in pytest as N individual test results, not 1? subtests?

def _get_env(key):
    value = os.getenv(key)
    if value is None:
        raise EnvironmentError('unable to find {} in ENV'.format(key))
    return value