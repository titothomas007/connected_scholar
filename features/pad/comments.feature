Feature: Add Comment
  In order to communicate with other contributors and the author of the document
  A user
  Should be able to add comments to the document.

    Background:
      Given I am logged in
      And I follow "New Document"
      And I fill in "Name" with "Comment Test Document"
      And I press "Create Document"
      And I follow "Comments"
      And I wait 1 seconds
      And I follow "Add Comment"
      And I should see "Add Comment"
      And I fill in "comment_comment_text" with "This is a great document"
      And I press "Create"
      And I wait 1 seconds

    @javascript
    Scenario: User adds a comment to the document
      Then I should see "This is a great document"
      And I should not see "new comment"

    @javascript
    Scenario: User adds a second comment to the document
      When I follow "Add Comment"
      And I should see "Add Comment"
      And I fill in "comment_comment_text" with "This is STILL a great document"
      And I press "Create"
      And I wait 1 seconds
      Then I should see "This is a great document"
      And I should see "This is STILL a great document"
      And I should not see "new comment"

    @javascript
    Scenario: User destroys a comment from the document
      When I preconfirm
      And I follow "Delete Comment"
      And I wait 1 seconds
      Then I should not see "This is a great document"

    @javascript
    Scenario: Contributor adds a comment to the document
      Given There is a contributor
      When I share the document with the contributor
      And I sign out
      And I log in as the contributor
      And I follow "Comment Test Document"
      And I should see "This is a great document"
      And I should not see "new comment"
      And I follow "Add Comment"
      And I fill in "comment_comment_text" with "A comment from a contributor"
      And I press "Create"
      And I wait 1 seconds
      And I should see "This is a great document"
      And I should see "A comment from a contributor"
      And I should not see "new comment"
      And I sign out
      And I go to the sign in page
      And I sign in as "admin@test.com/password"
      And I follow "Comment Test Document"
      And I should see "This is a great document"
      And I should see "1 new comment"
      And I should see "A comment from a contributor"
      