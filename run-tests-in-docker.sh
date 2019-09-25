docker exec -it robot-tests-platform bash -c "export TEST_PATH=/robot-tests-volume/src/$1 ; sh /robot-tests-volume/src/robot-tests-run-script.sh $2"
