from datetime import datetime
import glob
import os
from time import sleep
import requests
import json
import logging
import yaml
from yaml.loader import SafeLoader
import unittest


def time_test(time_expected,elapsed):
    def test():
        assert elapsed <= time_expected
    return test

def data_test(data_expected,data):
    def test():
        assert data == data_expected
    return test

token = os.getenv('TB_TOKEN')
folders = ['./test/*']
filenames = []
for x in folders:
    with open(glob.glob(x)[0]) as file:
        documents = yaml.full_load(file)
        type = documents["type"]
        name = documents["name"]
        tests = documents["tests"]
        if(tests is not None):
            suite = unittest.TestSuite()
            for test in tests:
                name_test = test["name"] 
                asserts = test["asserts"]
                for _assert in asserts:
                    for item, doc in dict(_assert).items():
                        if (item == "time"):
                            time = doc
                        elif(item == "data"):
                            data = doc
                response = requests.get (f"https://api.tinybird.co/v0/pipes/{name}.json?token={token}")
                json = response.json()
                data_result = str(json["data"])
                statistics = json["statistics"]
                elapsed_time = statistics["elapsed"]
                if(time is not None):
                    suite.addTest(unittest.FunctionTestCase(time_test(time,elapsed_time)))
                if(data is not None):
                    suite.addTest(unittest.FunctionTestCase(data_test(data,data_result)))

                #unittest.TestCase.assertLessEqual(time,1200)
            unittest.TextTestRunner().run(suite)
