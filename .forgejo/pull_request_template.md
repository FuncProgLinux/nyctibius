---
name: 'Pull Request'
about: 'Pull request template'
title: ''
ref: ''
labels:
---

- Package **update**
  - Build status of direct dependents (`./pre-inst-env guix build -k -P1 PACKAGE ...`):
```text

```
  - Link to upstream release notes (if applicable):
```text

```

- Package **addition**
  - [ ] Fixed errors reported by `guix lint` (`./pre-inst-env guix lint PACKAGE ...`).
  - [ ] Verified cryptographic signature provided by upstream.
  - [ ] The packages don't use bundled copies of software.

- [ ] The change doesn't break `guix pull` (`guix pull --url=/path/to/your/checkout --profile=/tmp/guix.master --disable-authentication`).
