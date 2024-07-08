*** Settings ***

Documentation  Cenários dde testes de atualização de tarefas

Resource    ../../resources/base.resource

Test Setup     Start Session
Test Teardown  Take Screenshot


*** Test Cases ***

#Deve poder marcar uma tarefa como concluída

  # ${data}    Get Fixture     tasks  done    

  # Reset user from database   ${data}[user]

#   Create a new task API  ${data}

 #  Do login               ${data}[user]

 #  Mark task as completed       ${data}[user][name]
  # Task should be completed    ${data}[user][name]
