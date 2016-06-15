# Contributing

Anyone and everyone is encouraged to fork Cortex and submit pull requests, propose new features and create issues.

* Ideally, we'd first like to hear your concerns or suggestions in the form of an [issue][issue]. We can all avoid
unnecessary re-work if a problem and its potential solution are first discussed before code is written.

* Fork on Github, then clone your repo:

```sh
git clone git@github.com:your-username/cortex.git
```

* Follow the [setup instructions][setup]

* Follow the [test suite instructions][test-suite], and ensure all tests pass

* Make your changes. Make frequent commits, but keep commits and commit messages focused on individual, atomic
feature changes or fixes. If you end up making many small commits during debug or development that belong to the same
chunk of functionality, squash those commits before creating a pull request.

* Add tests for your change. Once again, ensure all tests pass

* Push to a branch on your fork and [submit a pull request][pr]. Your PR must adhere to the following conventions:
  * For CareerBuilder team members, if the PR relates to a JIRA card, use the following naming convention:
    * `JIRA card #`: `PR Title`
    * Example: `COR-365: Unhandled Error on Media Upload`
  * For open source contributors, or if the PR does not relate to a JIRA card, use:
    * `PR Title`
    * Example: `Unhandled Error on Media Upload`
  * Names should use titleized capitalization. i.e.: `Login Form Redesign and Refactor`
  * Names should be dense, yet informative. For example, `Testing` is not an appropriate PR name, nor is
  `For update_url task, must use the body method to actually retrieve the stream from the S3 GetObjectOutput`.
  PR names are more high-level than commit messages.
  * PRs should be tagged appropriately (i.e. enhancement, bug, etc). Tags should be preferred over including things
  like 'bug' in the PR name.
  * If working with a versioned library, open source users should not include version bumps or changelog updates in
  their PRs.

From here, it's up to the Cortex maintenance team (<employersitecontentproducts@cb.com>). We operate in 2-week sprint
lifecycles, but we'll try to get to your request or contribution sooner. We may suggest further improvements or
alternatives, or the community at large may have input.

Some things that will increase the chances that your pull request will be accepted:

* Write [good tests][tests]
* Write [good commit messages][commit]
* If applicable, suggest additional options or alternatives, follow-up issues or potential future improvements

[issue]: https://github.com/cbdr/cortex/issues
[tests]: http://betterspecs.org
[commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[setup]: https://github.com/cbdr/cortex#setup
[pr]: https://github.com/cbdr/cortex/compare
[test-suite]: https://github.com/cbdr/cortex#running-test-suite
