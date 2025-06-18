### 1. Tags in Gherkin for Organising and Filtering Tests
> Tags allow us to categorize scenarios for better control over 
> test execution. Place them above features or individual scenarios.
>
####  Common tags:
`@smoke`: Lightweight tests to verify core functionality.

`@regression`: Broader tests to ensure previously working features still work.

`@wip`: Work-in-progress tests you’re actively developing.

#### Example
```gherkin
@smoke
Feature: Login Functionality

  @regression
  Scenario: Successful login
    Given the user is on the login page
    When the user logs in with valid credentials
    Then the user should see the dashboard

  @wip
  Scenario: Login with 2FA
    Given the user has enabled 2FA
    When they log in
    Then they should be prompted for a 2FA code
```
In this example: 
- The feature has the tag @smoke
- Each scenario inside the feature has its own tag (@regression or @wip)
- All scenarios inherit the feature’s tag (both scenarios have @smoke plus their own tags)

### 2. Configure Test Runner for Tag Filtering
> Use tag filters in your test runner CLI to include or exclude specific tests.

In the above example : 

Run Only Smoke Tests - 
``` bash 
cucumber --tags @smoke // runs both scenarios.
```
Run only Regression Tests -
``` bash 
cucumber --tags @regression // runs only the first scenario.
```
Run  only Work In Progress Tests - 
``` bash 
cucumber --tags @wip // runs only the second scenario.
```
Run Smoke Tests and Exclude Work In Progress Tests - 
``` bash 
cucumber --tags "@smoke and not @wip" // runs only the first scenario
```
### 3. Conditional Logic in Step Definitions

> we can use Cucumber hooks to vary behavior based on scenario tags or names, useful for:
> - Skipping validations during work-in-progress (`@wip`) tests
> - Logging or handling critical test flows differently
> - Dynamically adjusting behavior pre/post scenario execution
> 

example: 

```scala
Before { scenario =>
  val tags = scenario.getSourceTagNames
  if (tags.contains("@wip")) {
    println("[WIP WARNING] This scenario is marked as work-in-progress.")
    // Optionally skip steps or mock behavior
  }

  if (scenario.getName.contains("Critical")) {
    println("[🔍 INFO] Running a critical scenario: " + scenario.getName)
  }
}

After { scenario =>
  if (scenario.getStatus.name() != "PASSED") {
    println(s"[TEST FAILED] Scenario '${scenario.getName}' did not pass.")
  }
}
```

### 4. Generate separate reports for different test runs filtered by tags.

> We can set custom report output paths for each test type. 
> 