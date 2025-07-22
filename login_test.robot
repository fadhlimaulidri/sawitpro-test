*** Settings ***
Library           AppiumLibrary

Suite Setup       Start App Session
Suite Teardown    Close Application
Test Setup        Reset App

*** Variables ***
${REMOTE_URL}           http://localhost:4723
${PLATFORM_NAME}        Android
${DEVICE_NAME}          emulator-5554
${APP}                  Android.SauceLabs.Mobile.Sample.app.2.7.1.apk
${AUTOMATION_NAME}      UiAutomator2
${PLATFORM_VERSION}     12
${APP_PACKAGE}          com.swaglabsmobileapp

*** Test Cases ***
Login With Valid Username
    Input Text    accessibility_id=test-Username    standard_user
    Input Text    accessibility_id=test-Password    secret_sauce
    Click Element    accessibility_id=test-LOGIN
    Element Should Be Visible    xpath=//android.widget.TextView[@text='PRODUCTS']

Login With Invalid Password
    Input Text    accessibility_id=test-Username    standard_user
    Input Text    accessibility_id=test-Password    wrong_password
    Click Element    accessibility_id=test-LOGIN
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Username and password do not match any user in this service."]    10s
    ${error}=    Get Text    xpath=//android.widget.TextView[@text="Username and password do not match any user in this service."]
    Should Be Equal    ${error}    Username and password do not match any user in this service.

*** Keywords ***
Start App Session
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:app=${APP}
    ...    appium:platformVersion=${PLATFORM_VERSION}
    ...    appium:appWaitActivity=*
    ...    appium:appWaitDuration=30000

*** Keywords ***
Reset App
    Terminate Application    ${APP_PACKAGE}
    Sleep    1s
    Activate Application     ${APP_PACKAGE}
    Wait Until Element Is Visible    accessibility_id=test-Username    10s

