*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           Collections
Library           DateTime
Library           Dialogs
Library           String
Library           OperatingSystem
Library           Process
Library           XML
Library           Screenshot
Library           RequestsLibrary
Library           REST

*** Variables ***
${BASE_URL}       https://gorest.co.in/
${BEARERTOKEN}    Bearer ffc7fcdbe2f3d0c769219899102f4b15c41f5c518dd5feeb593bc6ca1beafe02
${BEARERNEWTOKEN}    "Bearer 61db2df3f928c1c32ed508420438691e304e6e9e5760bfc6811cc50543c7a228"

*** Test Cases ***
API Test - Get User List
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERTOKEN}    Content-Type=application/json
    ${response}    RequestsLibrary.Get Request    mysession    /public/v2/users    headers=${headers}
    ${jsonResp}    To Json    ${response.content}
    BuiltIn.Log To Console    json response is ${jsonResp}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    200

API Test - Get User by ID
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERTOKEN}    Content-Type=application/json
    ${response}    RequestsLibrary.Get Request    mysession    /public/v2/users/2911    headers=${headers}
    ${jsonResp}    To Json    ${response.content}
    BuiltIn.Log To Console    json response is ${jsonResp}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    200

API Test - Create User
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERTOKEN}    Content-Type=application/json
    ${req_body}    BuiltIn.Catenate    {"name":"TaslimArif Shaik",    "email":"shaiknet@han.net",    "gender":"male",    "status":"active"}
    log    ${req_body}
    ${response}    RequestsLibrary.Post Request    mysession    /public/v2/users    data=${req_body}    headers=${headers}
    ${jsonResp}    To Json    ${response.content}
    BuiltIn.Log To Console    json response is ${jsonResp}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    201

API Test - Update User by ID
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERTOKEN}    Content-Type=application/json
    ${req_body}    BuiltIn.Catenate    {"name":"TaslimArif Shaikres",    "email":"shaiknet@han.net",    "gender":"male",    "status":"active"}
    log    ${req_body}
    ${response}    Patch Request    mysession    /public/v2/users/3583    data=${req_body}    headers=${headers}
    ${jsonResp}    To Json    ${response.content}
    BuiltIn.Log To Console    json response is ${jsonResp}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    200

API Test - Delete User by ID
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERTOKEN}    Content-Type=application/json
    ${req_body}    BuiltIn.Catenate    {"name":"TaslimArif Shaikres",    "email":"shaiknet@han.net",    "gender":"male",    "status":"active"}
    log    ${req_body}
    ${response}    Delete Request    mysession    /public/v2/users/3583    data=${req_body}    headers=${headers}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    204

API Test - Create User - Status Code 401
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERNEWTOKEN}    Content-Type=application/json
    ${req_body}    BuiltIn.Catenate    {"name":"Arif Shaik",    "email":"Arifnet@han.net",    "gender":"male",    "status":"active"}
    log    ${req_body}
    ${response}    RequestsLibrary.Post Request    mysession    /public/v2/users    data=${req_body}    headers=${headers}
    ${jsonResp}    To Json    ${response.content}
    BuiltIn.Log To Console    json response is ${jsonResp}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    401

API Test - Get User by ID - Status Code 404
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERNEWTOKEN}    Content-Type=application/json
    ${response}    RequestsLibrary.Get Request    mysession    /public/v2/users/3583    headers=${headers}
    ${jsonResp}    To Json    ${response.content}
    BuiltIn.Log To Console    json response is ${jsonResp}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    404

API Test - Update User by ID - Status Code 422
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERTOKEN}    Content-Type=application/json
    ${req_body}    BuiltIn.Catenate    {" ",    "email":"taslimnet@han.net",    "gender":"male",    "status":"active"}
    log    ${req_body}
    ${response}    RequestsLibrary.Post Request    mysession    /public/v2/users    data=${req_body}    headers=${headers}
    ${jsonResp}    To Json    ${response.content}
    BuiltIn.Log To Console    json response is ${jsonResp}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    422

API Test - Update User by ID - Status Code 405
    Create Session    mysession    ${BASE_URL}
    ${headers}    BuiltIn.Create Dictionary    Authorization=${BEARERTOKEN}    Content-Type=application/json
    ${req_body}    BuiltIn.Catenate    {"name":"Taslim",    "email":"taslimnet@han.net",    "gender":"male",    "status":"active"}
    log    ${req_body}
    ${response}    RequestsLibrary.Post Request    mysession    /public/v2/users    data=${req_body}    headers=${headers}
    ${jsonResp}    To Json    ${response.content}
    BuiltIn.Log To Console    json response is ${jsonResp}
    ${Code}    BuiltIn.Convert To String    ${response.status_code}
    BuiltIn.Should Be Equal    ${Code}    405
