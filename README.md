# Project Notes

When setting up a DevOps pipeline, it's important that each step or stage is stable, that is it runs consistently and isn't prone to "drift" due to subtlely shifting environments.

When running integration tests with browser based applications, I like to use the Ruby programming language for a variety of reasons.

- Simple language syntax makes it easy to construct readable code; consider `log_in with_administrator_credentials` in Ruby as compared to `log_in(with_administrator_credentials());` or `LogIn(WithAdministratorCredentials());` where the semicolon and parentheses take away from the readability of the code
- While Ruby provides a rich and powerful dynamically typed object-oriented development paradigm, its metaprogramming capabilities allow us to build powerful constructs with a concise code-base, case in point Cheezy's Page Object library which uses this extensively to minimize the amount of boilerplate code you have to write to implement sophisticated Page Objects
    - While the Page Object example above illustrates the benefits of this capability in modelling a system's web UI, this capacity extends to all activities performed when integration testing: modelling the system itself, managing scenario test data, facilitating environment setup / teardown, etc.
- Using a different language than the implementation language of the system forces us to invent subtlely different ways of verifying correct application behaviour. As an industry we have come to realize that the code we write to verify correct behaviour is at least as important as the code that implements that behaviour. We have begun to realize that our integration / regression test suites are like "double-entry-accounting" to the software industry - while it looks redundant at first, it's a good practice that helps us catch errors.

# Docker Environments

This sample composes two Docker runtime environments:

1. A Ruby execution environment, in this case utilizing RSpec, Capybara and Selenium. Tests are expressed using standard RSpec expectation syntax and Ruby code.
2. A Chrome execution environment

The Ruby docker machine will execute the tests and drive the Chrome browser in the second docker machine via Selenium Remote.

Using this pattern, it should be clear to see how to create a Selenium Grid configuration where the tests are distributed across a number of browser VMs that can each run the same or different browsers for cross-browser verification.

# Running Tests

Run the browser integration tests in the Ruby project using the following command:

```
docker-compose up --exit-code-from tests
```

This will boot the entire system and execute the tests. There's a hard sleep in the test script currently to ensure that the selenium server has booted.

The `--exit-code-from` ensures that the pipeline picks up the exit code from the tests (pass/fail) and will force the dependant browser images to shut down (normally they'd run forever).

# Writing Tests

Tests go in the `spec` folder, look at `google_spec.rb` to get started.

This project was intended to be opinionated about how to configure Docker, but leave everything open to you to decide how you want to write your tests. Feel free to adjust the `Gemfile` to reflect your favourite Cucumber environment, and to arrange your test code in whatever manner you see fit.

# TODO

I'd also like to show folks how to capture test run data and publish it in different ways. For example, publishing a run report and screenshots to an AWS S3 bucket.

The hard sleep in the test script should be replaced with something less brittle, like waiting for port 4444 to become ready on the browser image(s).