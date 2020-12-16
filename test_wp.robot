*** Settings ***
Library  OperatingSystem
Library  Process
Suite Setup    Start wamp

*** Variables ***


*** Test Cases ***
Graph temperature BB
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\wamp_plotly\\venv\\Scripts\\python.exe  wamp_plotly.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Log  ${result.stdout}

*** Keywords ***
Start wamp
    Start Process  wamp.bat

