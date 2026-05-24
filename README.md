# Purpose
This repo exists to consolidate the downstream back end Cloud Run functions for RYLTY.

We need to enable independent development without communicating state between developers
so we slowly moved away from the mono-repo idea. The flip side is that it scatters the code
across many repos and makes cascading dependency changes (`ryltyhelpers` especially) harder.

So we bring them together in a meta repo.

# Develpoment

Submodule development workflow can be confusing for developers, so it's not recommended
you do your development in this repo unless you understand how it *should* work.

There are resources online for this, but to simplify, below are the basic points.
Assume a directory structure something like this, with root being the meta-repo.
```
$ tree
.
├── example1
└── example2
```
- If you are in a submodule directory, say `example1`), `git` behaves
  like it's in the repo itself. So the logs and status would be for `example1`.
- If you are in the meta-repo, the submodule directory status indicates the *commit hash*
  of meta-repo pointer for that submodule.
  - In this way, you can think of the submodule as a *pointer* to a commit.
  - Committing the submodule commits what the meta-repo understands as *its version*.
    Crucially, this can be different from the latest, but we aim to maintain the pointer
    to be the latest whenever possible.

  There are scripts in the directory to help with the dependency management.
