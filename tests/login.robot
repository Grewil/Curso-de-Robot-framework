*** Settings ***
Documentation   Cenários de autenticação do usuário

Library      Collections 

Resource   ../resources/base.resource
Resource    ../resources/Pages/LoginPage.resource

Test Setup     Start Session
Test Teardown  Take Screenshot
Library    ../resources/libs/database.py
Library    ../resources/libs/database.py

*** Test Cases ***

Deve poder logar com um usuário pré cadastrado

   ${user}   Create Dictionary
   ...  name=Gregory W Silva
   ...  email=gregorywillian@yahoo.com.br
   ...  password=Gwsilva2014  
   
   Remove user from database  ${user}[email]
   Insert user from database  ${user}
   Submit login form    ${user}
   User should be logger in  ${user}[name]

Não deve logar com senha inválida

      ${user}   Create Dictionary
   ...  name=Gregory W Silva
   ...  email=gregorywillian@yahoo.com.br
   ...  password=Gwsilva2014  
   
   Remove user from database  ${user}[email]
   Insert user from database  ${user}

   Set To Dictionary    ${user}   password=1234554

   Submit login form    ${user}
   Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.