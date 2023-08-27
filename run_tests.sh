#!/bin/bash

# It uses customizer parameter file tests.json

# Requirement:
# command zbarimg and xvfb-run
# it can be install with the following command on debian based linux
# apt-get -y install zbar-tools xvfb

mkdir -p tests

# colors
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
IReset='\e[0m'            # Reset colors

run_test() {
  testName=$1
  expectedResult=$2
  debug="-q" # quiet mode
  #debug="" # normal mode
  xvfb-run openscad $debug --autocenter --viewall --camera=0,0,0,0,0,0,200 -p tests.json -P "$testName" -o "tests/$testName.png" demo.scad

  #debug="-v" # verbose mode
  scanResult=$(zbarimg $debug -D --nodbus tests/$testName.png)
  if [[ "QR-Code:${expectedResult}" == "${scanResult}" ]]
  then
    echo -e "[${IGreen} OK ${IReset}] test $testName is ok"
  else
    echo -e "[${IRed} FAIL ${IReset}] test $testName failed. expected: QR-Code:$expectedResult but has result: $scanResult"
    exit 1
  fi
}

run_test "all" "https://openscad.org/cheatsheet/"
run_test "wifi_WPA" "WIFI:T:WPA;S:wifi_network;P:1234;;"
run_test "wifi2_WPA" "WIFI:T:WPA;S:wireless_fidelity;P:PigOtter;;"
run_test "wifi_WEP" "WIFI:T:WEP;S:wifi_network;P:1234;;"
run_test "wifi_nopass" "WIFI:T:nopass;S:wifi_network;P:;;"
run_test "wifi_hidden" "WIFI:T:WPA;S:wifi_network;P:1234;H:true;"
run_test "phone" "TEL:+33 1 23 45 67 89"
run_test "text_utf8" "lorem ipsum"
run_test "text_Shift_JIS" "|orem ipsum"
run_test "error_correction_M" "lorem ipsum1"
run_test "error_correction_Q" "lorem ipsum2"
run_test "error_correction_H" "lorem ipsum3"
run_test "mask_pattern_1" "lorem ipsum_1"
run_test "mask_pattern_2" "lorem ipsum_2"
run_test "mask_pattern_3" "lorem ipsum_3"
#run_test "mask_pattern_4" "lorem ipsum_4"
run_test "mask_pattern_5" "lorem ipsum_5"
run_test "mask_pattern_6" "lorem ipsum_6"
#run_test "mask_pattern_7" "lorem ipsum_7"

# do some cleanup
rm -Rf ./tests
