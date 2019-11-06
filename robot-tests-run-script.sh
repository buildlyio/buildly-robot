cd /robot-tests-volume/src

bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://buildly:8080/health_check/)" != "200" ]]; do sleep 5; echo Wait for buildly; done'
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://productsservice:8080/health_check/)" != "200" ]]; do sleep 5; echo Wait for productservice; done'
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://locationservice:8080/health_check/)" != "200" ]]; do sleep 5; echo Wait for locationservice; done'


rm -f output-$1/output.xml
rm -f output-$1/rerun.xml
rm -f output-$1/first_run_log.html
rm -f output-$1/second_run_log.html
rm -f output-$1/keywords.html

# ignore urllib3/connectionpool.py:847: InsecureRequestWarning: Unverified HTTPS request
export PYTHONWARNINGS="ignore:Unverified HTTPS request"

echo
echo "#######################################"
echo "# Running test suite a first time     #"
echo "#######################################"
echo
if xvfb-run --server-args="-screen 0 1920x1080x24" \
      robot --loglevel TRACE:INFO \
            --outputdir=./output-$1 \
            --exclude Quarantine \
            --variable env:$1 ${TEST_PATH}; then
  # we stop the script here if all the tests were OK
	echo "we don't run the tests again as everything was OK on first try"
  echo "Creating keyword documentation"
  python -m robot.testdoc -e Quarantine robot-tests output-$1/keywords.html
	exit 0
fi
# otherwise we go for another round with the failing tests
# we keep a copy of the first log file
cp output-$1/log.html  output-$1/first_run_log.html
fail="1"
# we launch the tests that failed
echo
echo "#############################################"
echo "# Running again the test suites that failed #"
echo "#############################################"
echo
if xvfb-run --server-args="-screen 0 1920x1080x24" \
      robot --loglevel TRACE:INFO \
            --rerunfailedsuites output-$1/output.xml \
            --outputdir=./output-$1 --output rerun \
            --exclude Quarantine \
            --variable env:$1 ${TEST_PATH}; then
  echo "Tests passed on second try"
  echo "Creating keyword documentation"
  python -m robot.testdoc -e Quarantine robot-tests output-$1/keywords.html
else
  echo "Test failed on second try."
  fail="2"
fi
# Robot Framework generates file rerun.xml
# we keep a copy of the second log file
cp output-$1/log.html  output-$1/second_run_log.html
# Merging output files
echo
echo "########################"
echo "# Merging output files #"
echo "########################"
echo
rebot --nostatusrc --outputdir ./output-$1 --merge output-$1/output.xml output-$1/rerun.xml
# Robot Framework generates a new output.xml

if [ $fail -eq 2 ]; then
    echo
    echo "Exit code 1"
    echo
    exit 1
fi
