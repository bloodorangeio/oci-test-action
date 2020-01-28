# oci-test-action

## Overview

GitHub Action for running the [OCI Distribution Spec conformance tests](https://github.com/opencontainers/distribution-spec/tree/master/conformance).

## Example Usage

Note: the following example expects that `OCI_USERNAME` and `OCI_PASSWORD` have been setup as GitHub secrets. 

This example workflow will run the conformance tests against your registry and archive the test results:

```yaml
# Place in repo at .github/workflows/oci-test.yml
name: oci-test
on: push
jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - name: Run OCI Distribution Spec conformance tests
        uses: bloodorangeio/oci-test-action@v1.0.0-alpha.2
        env:
          OCI_ROOT_URL: https://quay.io
          OCI_NAMESPACE: bloodorange/oci-conformance-test
          OCI_USERNAME: ${{ secrets.QUAY_USERNAME }}
          OCI_PASSWORD: ${{ secrets.QUAY_PASSWORD }}
      - run: mkdir -p .out/ && mv {report.html,junit.xml} .out/
        if: always()
      - name: Upload test results zip as build artifact
        uses: actions/upload-artifact@v1
        with:
          name: oci-test-results-${{ github.sha }}
          path: .out/
        if: always()
```

## Adding a Badge

You can add a badge pointing to list of runs for this action using the following markdown:

```
[![](https://github.com/<org>/<repo>/workflows/oci-test/badge.svg)](https://github.com/<org>/<repo>/actions?query=workflow%3Aoci-test)
```

(replacing `<org>` and `<repo>` with your GitHub repo details)
