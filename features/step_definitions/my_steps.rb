When(/^I touch the Cyrus map photo pin$/) do
  touch "view:'PhotoAnnotationView' marked:'Cyrus Innovation'"
end

Then(/^I should see a map centered at my current location$/) do
  check_element_exists "view:'MKUserLocationView' marked:'Current Location'"
end

Then(/^I should see pins for photos near me$/) do
  check_element_exists "view:'PhotoAnnotationView' marked:'Cyrus Innovation'"
end

Then(/^I should see the photo title$/) do
  wait_for_frank_to_come_up
  check_element_exists "view:'UILabel' marked:'Cyrus Innovation'"
end
