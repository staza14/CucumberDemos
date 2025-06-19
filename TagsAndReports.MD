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

## Types of Reports Cucumber Can Generate
> Cucumber can generate several report formats automatically, which are useful for reviewing 
> what passed, what failed, and why
>

| Format              | What It’s For                                                             | How It’s Used                               |
| ------------------- | ------------------------------------------------------------------------- | ------------------------------------------- |
| **HTML**            | Human-readable report in a browser. Shows features, scenarios, pass/fail. | Great for manual review.                    |
| **JSON**            | Structured data used by other tools (e.g. Allure).                        | Used for integrations and advanced reports. |
| **JUNIT/XML**       | Standard format for CI systems like Jenkins or GitLab.                    | Enables tracking test history, trends.      |
| **Pretty/Progress** | Console output for development use.                                       | Not usually saved, just helps debugging.    |

## Integrate Cucumber reports with third-party tools like Allure or ExtentReports

1. Allure Reports
   - Allure is a powerful third-party reporting tool that turns JSON or XML results into 
interactive dashboards.
   - Generate a JSON report from Cucumber
   - Use Allure CLI or Maven plugin to transform JSON into HTML dashboards.
   - View insights like time per test, failure screenshots, environment info.

2.  ExtentReports
   - to write customer formatters
   - allows colored test logs
   - allows custom dashboards
   - allows embedded screenshots

### Parallel Test Execution in Cucumber
> A test suite many have many scenarios, if it does, it will
> take a long time to run in sequence. Running them in 
> parallel saves time
> 
> Cucumber doesn’t run each step in parallel, but rather each feature file.
>
> You split your test files across different threads or processes.
>

Challenges of this:

| Challenge                 | What It Means                                                        |
| ------------------------- | -------------------------------------------------------------------- |
| **Shared state**          | Global variables might get overwritten between threads.              |
| **Database collisions**   | Multiple tests writing to the same DB can conflict.                  |
| **Test order dependency** | If your tests depend on each other, they might fail in parallel.     |
| **Reporting**             | Merging multiple JSON/HTML files into one readable report is tricky. |
