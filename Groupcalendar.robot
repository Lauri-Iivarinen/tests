*** Settings ***
Library         SeleniumLibrary   15.0   5.0

*** Variables ***
${Browser}      Chrome
##If testing the app in heroku, make sure heroku server has already been awakened and change ${URL} accordingly
${URL}          http://localhost:8080
${Sleep}	    2
#password for test user
${Password}    kayttaja


#Starting assumption for tests is that no test-groups(ids 1 and 2) have been deleted and user is a member of both
#Also no events have been created in group family-test

*** Test Cases ***
Page Open Test Case
    Open Website
    Page Should Contain    Group calendar

Login Test Case
    Click Link    Login
    Odota
    Input Text    username    user
    Input Password    password    ${Password}
    Click Button    Login
    Odota
    Page Should Contain    user

Group List Test Case
    Click Link    Find new groups
    Page Should Contain    family-test
    Page Should Contain    friends-test
    Click Link    Back
    Odota
    Page Should Contain    user

Go To Family-test Test Case
    Go To    ${URL}/grouphome/2
    Odota
    Page Should Contain    test-group
    Page Should Contain    Members:

Create Event Test Case
    Click Link    Create new event
    Odota
    Input Text    title    Birthday
    Input Text    location    Narnia
    Input Text    date    12.12.2022
    Click Button    CREATE
    Odota
    Page Should Contain    Upcoming events
    Page Should Contain    Birthday
    Page Should Contain    Narnia
    Page Should Contain    12.12.2022

Signup To Event Test Case
    Page Should Contain    Participants
    Page Should Contain    1
    Page Should Contain    Yes
    Click Link    Cancel participation
    Odota
    Page Should Contain    Participating
    Page Should Contain    0
    Page Should Contain    No

Remove Event Test Case
    Click Link    Remove event
    Odota
    Page Should Not Contain    Birthday


Logging Out Test Case
    Click Button    LOGOUT
    Odota
    Page Should Contain    Group calendar

*** Keywords ***
Open Website
        TRY
                Open Browser    ${URL}       ${BROWSER}
                Sleep   ${Sleep}
        EXCEPT
                Fatal Error    Unable to open ${URL}.
        END

Odota
    Sleep    ${Sleep}
