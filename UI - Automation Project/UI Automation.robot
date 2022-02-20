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
${BROWSER_NAME}    chrome
${URL_ADDRESS}    https://www.amazon.com/
${PRODUCT_NAME}    Kindle

*** Test Cases ***
Amazon's homepage search
    # Login and Search for “Kindle” on Amazon’s homepage #
    Open Browser    ${URL_ADDRESS}    ${BROWSER_NAME}
    Maximize Browser Window
    Input Text    //*[@id="twotabsearchtextbox"]    ${PRODUCT_NAME}
    Click Element    //*[@id="nav-search-submit-button"]
    Sleep    2s
    Capture Page Screenshot
    #Select items and verify user navigates to product page#
    ${Status}    Run Keyword And Return Status    Page Should Contain Element    //*[contains(text(),'All-new Kindle Paperwhite')]
    Run Keyword If    "${Status}" == "True"    Click Element    //*[contains(text(),'All-new Kindle Paperwhite')]
    ...    ELSE    Fail    Produt Name - All-new Kindle Paperwhite not displayed
    Capture Page Screenshot
    ${Status}    Run Keyword And Return Status    Page Should Contain Element    //*[@id="add-to-cart-button"]
    Run Keyword If    "${Status}" == "True"    Run Keywords    Execute Javascript    window.scrollBy(0,400)
    ...    AND    Sleep    2s
    ...    AND    Click Element    //*[@id="pav-desktop-secondary-view"]
    ...    ELSE    Fail    Produt page is not displayed
    Sleep    3s
    Click Link    //a[@href="/dp/B08KTZ8249/ref=pav_secondary_title_m_fromAsin_B08KTZ8249_toAsin_B08KTZ8249"]
    Sleep    3s
    Click Element    //*[contains(text(),'Without Ads')]
    Sleep    5s
    #Verify if the item is added to the cart#
    Click Element    //*[@id="add-to-cart-button"]
    Sleep    3s
    Click Element    //*[@id="abb-intl-pop-cta"]/span[3]/span/input
    Wait Until Element Is Visible    //*[contains(text(),'Added to Cart')]
    Capture Page Screenshot
    ${Status}    Run Keyword And Return Status    Page Should Contain Element    //*[contains(text(),'Added to Cart')]
    Run Keyword If    "${Status}" == "False"    Fail    Product is not added to the Cart
    ...    ELSE    Log    Product is added to Cart
    Close Browser

*** Keywords ***
