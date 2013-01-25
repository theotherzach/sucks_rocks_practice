Feature: Users can learn how good something is

  Scenario: Uer compares two terms
    When I search for microsoft
    And I search for apple
    Then apple should have a higher score than microsoft
