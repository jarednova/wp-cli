Feature: Manage WordPress menus

  Background:
    Given a WP install

  Scenario: Menu CRUD operations

    When I run `wp menu create "My Menu"`
    And I run `wp menu list --fields=name,slug`
    Then STDOUT should be a table containing rows:
      | name       | slug       |
      | My Menu    | my-menu    |

    When I run `wp menu delete "My Menu"`
    And I run `wp menu list --format=count`
    Then STDOUT should be:
    """
    0
    """

  Scenario: Assign / remove location from a menu

    When I run `wp theme activate twentythirteen`
    And I run `wp menu theme-locations`
    Then STDOUT should be a table containing rows:
      | location       | description        |
      | primary        | Navigation Menu    |

    When I run `wp menu create "Primary Menu"`
    And I run `wp menu assign-location primary-menu primary`
    And I run `wp menu list --fields=slug,locations`
    Then STDOUT should be a table containing rows:
      | slug            | locations       |
      | primary-menu    | primary         |

    When I run `wp menu remove-location primary-menu primary`
    And I run `wp menu list --fields=slug,locations`
    Then STDOUT should be a table containing rows:
      | slug            | locations       |
      | primary-menu    |                 |
