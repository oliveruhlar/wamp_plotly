*** Settings ***
Library  OperatingSystem
Library  Process
Library  DatabaseLibrary
Suite Setup    Start wamp

*** Variables ***


*** Test Cases ***
Test wamp is booted  
    Wait Until Keyword Succeeds	 40s  5s  Is wamp booted
    Disconnect From Database
Graph temperature BB
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\wamp_plotly\\venv\\Scripts\\python.exe  wamp_plotly.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Log  ${result.stdout}

*** Keywords ***
Start wamp
    Start Process  wamp.bat
Is wamp booted
    Connect To Database  dbConfigFile=db.cfg

    @{queryResults}  Query	select * from bb_2019_temperature
    Log Many	@{queryResults}

