*** Settings ***
Library  ../Utils/petsLibrary.py
Library  RequestsLibrary
Library  JSONLibrary
Variables  petsvariable.py

*** Variables ***
${baseURL}  https://petstore.swagger.io/

*** Test Cases ***

Add Pet to Store
    ${petsJson}=  petsLibrary.Generate Add New Pet To Store Json  id=${id}  category=${category}  name=${name}  photoUrls=${photoUrls}  tags=${tags}  status=${status}
    ${petsJson}=  JSONLibrary.Convert String To Json  ${petsJson}
    Log    ${petsJson}
    RequestsLibrary.Create Session  session  url=${baseURL}  headers=${header}
    ${response}=  RequestsLibrary.POST On Session  session  v2/pet  headers=${header}  json=${petsJson}
    Log  ${response.content}
    Log  ${response.status_code}
    Should Be Equal  ${response.status_code}  ${200}