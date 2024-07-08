*** Settings ***

Documentation  Cenários dde testes de remoção de tarefas

Resource    ../../resources/base.resource

Test Setup     Start Session
Test Teardown  Take Screenshot


*** Test Cases ***

Deve poder Apagar uma tarefa como indesejada

   ${data}    Get Fixture     tasks  delete    
   
  Reset user from database   ${data}[user]

   Create a new task API  ${data}

   Do login               ${data}[user]
   
   Request removal          ${data}[task][name]
   Task should not exixt    ${data}[task][name]
   
