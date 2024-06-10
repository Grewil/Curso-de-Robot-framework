*** Settings ***
Documentation   Ações e elementos da página de login

Library   String
Library   Browser

*** Keywords ***

Submit login form

  [Arguments]   ${user}   

  Fill Text    css=input[placeholder$=mail]    ${user}[email]
  Fill Text    css=input[placeholder=Senha]    ${user}[password]
  
  Click        css=button >> text=Entrar

User should be logger in 

  [Arguments]    ${name}

  @{splited_name}  Split String    ${name}

  Log   ${splited_name}

  ${element}   Set Variable   css=header .right small

  Wait For Elements State     ${element}
  ...  visible   5
   
  Get Text     ${element}  equal   Olá, ${splited_name}[0]


  
  