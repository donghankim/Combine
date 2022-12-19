Feature: Recommendations
    Background:
        Given friend has logged in
        Given friend has added media
        Given they have logged out
        Given user has logged in
        Given they are friends
        Given I am on the recommendations page

    Scenario: No Friends
        When I delete my friend
        And I press "Recommendations"
        Then I should see no recommendations

    #Scenario: Recommend Media