*** Settings ***

Documentation   Cenários de testes do cadastros de usuários

Resource  ../resources/base.resource
Resource    ../resources/Pages/SignupPage.resource

#Suite Setup     Log  Tudo aqui ocorre antes da suite (antes de todos os testes)
#Suite Teardown  Log  Tudo aqui ocorre depois da suite (depois de todos os testes)

test setup   Start Session
test teardown  Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário

  ${user}    Create Dictionary  
  ...  name=Gregory W Silva  
  ...  email=gregorywillian@yahoo.com.br  
  ...  password=Gwsilva2014
  
   Remove user from database       ${user}[email]

  Go to signup page
  Submit signup form    ${user}
  Notice should be      Boas vindas ao Mark85, o seu gerenciador de tarefas.
  
Não deve permitir o cadastro com email duplicado

   [tags]   dup
  ${user}    Create Dictionary
  ...  name=Gregory
  ...  email=gregorywillian@hotmail.com.br
  ...  password=Gwsilva2014

  Remove user from database  ${user}[email]
  insert user from database  ${user} 
  
  Go to signup Page
  Submit signup form    ${user}
  Notice should be      Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios

   [Tags]  required

   ${user}   Create Dictionary
   ...       name=${EMPTY}
   ...       email=${EMPTY}
   ...       password=${EMPTY}
   
   Go to signup page
   Submit signup form    ${user}
  

   Alert should be   Informe seu nome completo
   Alert should be   Informe seu e-email
   Alert should be   Informe uma senha com pelo menos 6 digitos


Não deve cadastrar com email incorreto
     [Tags]   inv_email

     ${user}  Create Dictionary
     ...      name=Gregory Silva
     ...      email=gregor.com.br 
     ...      password=123456
     
    
     Go to signup page
     Submit signup form    ${user} 
     alert should be       Digite um e-mail válido

Não deve cadastrar com senha muito curta

   [tags]   temp 

   @{password_list}    Create List   1  12  123  1234  12345

   FOR  ${password}   IN  @{password_list}
         ${user}   Create Dictionary

            ${user}   Create Dictionary
           ...       name=Gregory
           ...       email=gregory@yahoo.com
           ...       password=${password}
   
          Go to signup page
          Submit signup form    ${user}
  
          Alert should be   Informe uma senha com pelo menos 6 digitos
    END

Não deve cadastrar com senha de 1 digito


   [Tags]  Short_pass
   [Template]
   Short password   1
Não deve cadastrar com senha de 2 digito

   [Tags]  Short_pass
   [Template]
   Short password   12

Não deve cadastrar com senha de 3 digito

   [Tags]  Short_pass
   [Template]
   Short password   123

Não deve cadastrar com senha de 4 digito

   [Tags]  Short_pass
   [Template]
   Short password   1234

Não deve cadastrar com senha de 5 digito

   [Tags]  Short_pass
   [Template]
   Short password   12345
    
*** Keywords ***
Short password
   [Arguments]    ${short_pass}

   ${user}   Create Dictionary
   ...       name=Gregory
   ...       email=gregory@yahoo.com
   ...       password=1
   
   Go to signup page
   Submit signup form    ${user}
  
   Alert should be   Informe uma senha com pelo menos 6 digitos
