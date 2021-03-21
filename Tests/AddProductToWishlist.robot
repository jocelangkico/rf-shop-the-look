*** Settings ***
Suite Setup    Open Site as Guest    ${WestWingNow_URL}    ${Browser}
Suite Teardown  Logout and Close Browser
Resource    ../Resources/Keywords.robot

*** Test Cases ***
Product Should be Added to Wishlist after Successful Login
    # Search
    Log to Console    ${\n}SEARCH PRODUCT
    Search a Product    ${TermMobel}
    Verify If Element Is Present    ${ProductList}
    Close Sign Up Overlay if Present
    # Add product to Wishlist
    Log to Console    ${\n}ADD PRODUCT TO WISHLIST
    Add Product to Wishlist
    # Login
    Log to Console    ${\n}LOGIN
    Switch to Login Mode
    Login    ${ExistingUserEmail}    ${ExistingUserPassword}
    # Verify Wishlist
    Log to Console    ${\n}VERIFY PRODUCT IS ADDED TO WISHLIST
    Verify if Product is Added to Wishlist  1
    # Delete Product in Wishlist
    Log to Console   ${\n}DELETE PRODUCT TO WISHLIST
    Verify if Element is Present    ${Header_WishlistIcon}
    Click Element   ${Header_WishlistIcon}
    Delete Product in Wishlist
    Verify if Element is Present    ${Wishlist_NoProducts}
    Verify if Element is not Present    ${Header_WishlistIconCounter}