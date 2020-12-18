*** Settings ***
Library  OperatingSystem
Library  Process
Library  DatabaseLibrary
Suite Setup    Start setup
Suite Teardown  Teardown setup

*** Variables ***


*** Test Cases ***
Test wamp is booted  
    Wait Until Keyword Succeeds	 40s  5s  Is wamp booted

Create table
    Query	CREATE TABLE temp_bb (`Months` varchar(20), `Max temperature` float, `Min temperature` float, `Avg temperature` float)
    Table Must Exist	temp_bb
    Row Count Is Equal To X  SELECT * FROM temp_bb  0

Insert data from yaml
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\wamp_plotly\\venv\\Scripts\\python.exe  load_data.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Query  ${result.stdout}
    ${rowCount}	Row Count	SELECT * FROM temp_bb
    Should Be Equal As Integers  ${rowCount}  12
    ${output}	Query	 SELECT * FROM temp_bb
    Log Many	${output}

Graph temperature BB
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\wamp_plotly\\venv\\Scripts\\python.exe  wamp_plotly.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Log  ${result.stdout}

Drop table
    Query  DROP TABLE temp_bb
    Run Keyword And Expect Error	Table 'temp_bb' does not exist in the db	 Table Must Exist  temp_bb

*** Keywords ***
Start setup
    Start Process  wamp.bat

Is wamp booted
    Connect To Database  dbConfigFile=db.cfg

Teardown setup
    Disconnect From Database

