Feature: Create script
    In order to create test cases Riurik provides test scripts creation feature

Scenario:
    Given it is necessary to create the first-test.coffee script in the folder-for-tests suite
    When user riurik is in the given folder
    Then he dose not see the given script
        But he sees the Create Script link
    When the link is pushed
    Then the user sees the Create Script dialog
    When he types given test name
        And press the OK button
    Then new test script should be created