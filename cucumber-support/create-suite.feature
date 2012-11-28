Feature: Create suite

  Scenario:
    Given it is necessary to create the folder-for-tests suite in the riurik directory index
    When user riurik is on the front-page
    Then he dose not see the given folder
      But he sees the Create Suite link
    When the link is pushed
    Then the user sees the Create Suite dialog
    When he types given folder name
      And press the create button
    Then new folder should be created