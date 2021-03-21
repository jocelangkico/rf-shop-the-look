*** Settings ***
Library	SeleniumLibrary
Resource	Locators.robot
Resource	Variables.robot

*** Keywords ***
Accept Cookies
    [Documentation]    This keyword will click 'Accept Cookies' button.
    Click Button    ${PrivacyPolicy_AcceptCookies}
    Verify If Element Is Not Present   ${PrivacyPolicy}

Login    [Arguments]    ${email}    ${password}
    [Documentation]    This keyword will sign in to the site.
    Input Text    ${LoginRegisterOverlay_EmailInputField}    ${email}
    Input Text    ${LoginRegisterOverlay_PasswordInputField}    ${password}
    Click Button    ${LoginRegisterOverlay_LoginButton}
    ${isLoggedIn}=    Run Keyword And Return Status    Page Should Contain Element    ${Customer_MyAccount}
    IF    ${isLoggedIn} == ${True}
        Log To Console    Logged In Successfully With: ${email} / ${password}
    ELSE
        Fail    Unsuccessful Login
    END

Logout and Close Browser
    [Documentation]    This keyword will sign out the current user.
    log to console    LOGOUT
    Verify If Element Is Present    ${Customer_MyAccount}
    # Logout
    Set Selenium Speed  ${RetryInterval}
    Mouse Over    ${Customer_MyAccount}
    Set Selenium Speed  0
    Wait Until Element Is Visible   ${Customer_MyAccountLogoutLink}
    Set Focus To Element    ${Customer_MyAccountOverlay}
    Click Link   ${Customer_MyAccountLogoutLink}
    Verify If Element Is Present     ${Header_SignUpLink}
    # Close browser
    Close Browser

Open Site as Guest	[Arguments]	${url}	${browser}
	[Documentation]	This keyword will open the site as guest.
	Open Browser    ${url}    ${browser}
	Wait Until Keyword Succeeds    ${Retry}    ${RetryInterval}    Maximize Browser Window
	# Check if the Privacy Policy is present on the page then accept
	${isPrivacyPolicyVisible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PrivacyPolicy}    5s
	IF  ${isPrivacyPolicyVisible} == ${True}
	    Accept Cookies
	ELSE
	    No Operation
	END

Verify if Element is Present   [Arguments]     ${locator}
    [Documentation]    This keyword will try to verify if the element identified in locator
    ...    is found on the current page and will retry if fails.
    Wait Until Keyword Succeeds    ${Retry}     ${RetryInterval}    SeleniumLibrary.page should contain element    ${locator}
    Log To Console  Verified page contain : ${locator}

Verify if Element is not Present   [Arguments]     ${locator}
    [Documentation]    This keyword will try to verify if the element identified in locator
    ...    is not found on the current page and will retry if fails.
    Wait Until Keyword Succeeds     ${Retry}    ${RetryInterval}    Page Should Not Contain Element    $(locator)
    Log To Console  Verified page does not contain : ${locator}