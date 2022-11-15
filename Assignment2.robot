*** Settings ***
Library         SeleniumLibrary   15.0   5.0

*** Variables ***
${Browser}      Chrome
${URL}          http://localhost:8080
${Sleep}	    3

*** Test Cases ***
Open Webpage Test Case
    Open Browser    ${URL}       ${BROWSER}
	Sleep	${SLEEP}
    Page Should Contain    This is a demo application

Page Has Add Button Test Case
    Page Should Contain Button    Add to list

Add Item Test Case
    Page Should Not Contain    Pasta
    Lisaa Pasta
    Page Should Contain    Pasta
    Click Button    xpath:(.//button[contains(., '×')])[last()]
    Page Should Not Contain     Pasta

Number Of Items In List Test Case
    Page Should Contain    3
    Lisaa Pasta
    Page Should Contain    4
    Click Button    xpath:(.//button[contains(., '×')])[last()]
    Page Should Contain    3


#Metodi?
*** Keywords ***
Lisaa Pasta
    #new-item-title on lähdekoodista löytyvä id input fieldille
    Input Text    new-item-title    Pasta
    Click Button    Add to list
