Feature: View map with pins representing photos near my current location

Background:
    Given I launch the app

Scenario: Map is shown when app is launched
    Then I should see a map centered at my current location
        And I should see pins for photos near me

Scenario: View photo title
    When I touch the Cyrus map photo pin
    Then I should see the photo title

Scenario: Show photo
    When I touch the Cyrus map photo pin
        And I see the photo title
        And I touch the more info icon
    Then I should see the photo
