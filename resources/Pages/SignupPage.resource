*** Settings ***

Documentation    Elementos e ações da pagina de cadastro

Library    Browser
Resource   ../env.resource

*** Keywords ***
Go to signup page

    Go to      ${BASE_URL}/signup

   # Checkpoint
    Wait for Elements State   css=h1       visible   3
    Get Text                  css=h1       equal     Faça seu cadastro

Submit signup form
   [Arguments]   ${user}

   Fill Text                css=input[name=name]           ${user}[name]
   Fill Text                css=input[name=email]          ${user}[email]
   Fill Text                css=input[name=password]       ${user}[password]

   Click                    css=button[type=submit] >> text=cadastrar


Alert should be
  
  [Arguments]   ${expected_text}

  Wait For Elements State    css=.alert-error >> text=${expected_text}
   ...  visible   5