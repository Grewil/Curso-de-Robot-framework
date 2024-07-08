*** Settings ***

Library   libs/database.py
Library   Browser
Library  JSONLibrary

Resource  env.resource

Resource  pages/Components/Notice.resource
Resource  pages/SignupPage.resource
Resource  pages/LoginPage.resource
Resource  pages/Components/Header.resource
Resource  pages/TaskCreatePage.resource
Resource  Pages/TasksPage.resource
Resource  services.resource


*** Keywords ***
Start Session 

   New Browser  browser=${BROWSER}    headless=False
   New Page    ${BASE_URL} 

# Helpers

Get Fixture
   [Arguments]  ${file_name}   ${scenario}

   ${data}    Load Json From File   
   ...    ${EXECDIR}/resources/Fixtures/${file_name}.Json   
   ...    encoding=utf-8
    
    [Return]  ${data}[${scenario}]


Reset user from database

  [Arguments]   ${user}

   Clean user from database      ${user}[email]
   Insert user from database     ${user}

Create a new task API
  
  [Arguments]   ${data}  

   POST user Session    ${data}[user]
   POST a new task      ${data}[task]

Do login

   [Arguments]    ${user}

  Submit login form         ${user}
  User should be logger in  ${user}[name]