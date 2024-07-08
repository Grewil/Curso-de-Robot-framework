*** Settings ***

Documentation   Cenários de cadastro de tarefas

Library     JSONLibrary
Resource     ../../resources/base.resource

Test Setup   Start Session
Test Teardown  Take Screenshot


*** Test Cases ***

Deve poder cadastrar uma nova tarefas
    
   ${data}   Get fixture  tasks  create

   Reset user from database   ${data}[user]
  
   Submit login form         ${data}[user]
   User should be logger in  ${data}[user][name]

   Go to task form
   Submit task form              ${data}[task]
   Task should be registered     ${data}[task][name]

Não deve cadastrar tarefa com nome duplicado
    [Tags]   dup

   ${data}   Get fixture  tasks  duplicate

   #Dado que eu tenho um novo usuário

    Reset user from database   ${data}[user]
   
   # E que esse usuário ja cadastrou uma tarefa

   Create a new task API  ${data}

   # E que estou logado na aplicação

   Submit login form         ${data}[user]
   User should be logger in  ${data}[user][name]
   
   # Quando tento cadastrar essa tarefa que já foi cadastrado

   Go to task form
   Submit task form              ${data}[task]
   
   # E então devo ver uma notificação de duplicidade

   Notice should be    Oops! Tarefa duplicada.

Não pode cadastrar quando uma nova tarefa atinge o limite de Tags

  [tags]   tags_limit

  ${data}   Get fixture  tasks  tags_limit

   Reset user from database   ${data}[user]
   
   Do login               ${data}[user]
  
   Go to task form
   Submit task form              ${data}[task]
   
   Notice should be    Oops! Limite de tags atingido.
  