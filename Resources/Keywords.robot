*** Settings ***
Resource    CommonResources.robot

*** Keywords ***
Add Product to Wishlist
    [Documentation]    This keyword will add a product to the Wishlist.
    Verify If Element Is Present    (${Wishlist_IconButton})[1]
    Click Element   (${Wishlist_IconButton})[1]

Delete Product in Wishlist
    [Documentation]    This keyword will delete a product to the Wishlist.
    Verify If Element Is Present    ${Wishlist_Products}
    Set Selenium Speed  ${RetryInterval}
    Click Button   (${Wishlist_ProductsDeleteButton})[1]
    Set Selenium Speed  0

Search a Product    [Arguments]    ${product}
    [Documentation]    This keyword will enter a keyword to search for a product.
    Page Should Contain Element     ${SearchInputField}
    Input Text    ${SearchInputField}    ${product}
    Press Keys    ${SearchInputField}    ${EnterKey}
    Log To Console    Searched Product : ${product}

Switch to Login Mode
    [Documentation]    This keyword will switch the Login/Register overlay to Login mode.
    ${mode}=    Run Keyword And Return Status    Page Should Contain Element    ${LoginRegisterOverlay_RegistrationMode}    5s
    IF    ${mode} == ${True}
        Click Button    ${LoginRegisterOverlay_SwitchLink}
        Wait Until Element Is Visible    ${LoginRegisterOverlay_LoginMode}
    ELSE
        Click Button    ${LoginRegisterOverlay_SwitchLink}
        Wait Until Element Is Visible    ${LoginRegisterOverlay_RegistrationMode}
    END

Close Sign Up Overlay if Present
    [Documentation]    This keyword will close the sign up overlay if it appears on the page.
    # Check if the Sign Up Overlay is present
    ${status_signUpOverlay}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SignUp_Overlay}    5s
    IF  ${status_signUpOverlay} == ${True}
        Click Element At Coordinates    ${SignUp_Overlay}    250    250
        Wait Until Element Is Not Visible   ${SignUp_Overlay}    5s
    ELSE
        No Operation
    END

Verify if Product is Added to Wishlist  [Arguments]    ${wishlistCount}
    [Documentation]    This keyword will verify the wishlist icon and count upon adding product to wishlist.
    Wait Until Element Is Visible    ${ProductList}
    # Verify if wishlist icon is filled
    Verify If Element Is Present    ${Wishlist_IconSelected}
    # Verify wishlist count
    ${isCounterVisible}=    Run Keyword And Return Status    Wait Until Keyword Succeeds    ${Retry}     ${RetryInterval}    Page Should Contain Element    ${Header_WishlistIconCounter}
    ${currentCount}=    Get Element Attribute    ${Header_WishlistIconCounter}  innerHTML
    IF  ${isCounterVisible} == ${True}
        Should Be Equal As Numbers    ${currentCount}   ${wishlistCount}
        Log To Console    Wishlist Count : ${currentCount}
    ELSE
        Log To Console  Product Is Not Added To The Wishlist
    END