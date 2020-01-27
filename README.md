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
        uses: bloodorangeio/oci-test-action@@v1.0.0-alpha.1
        env:
          OCI_ROOT_URL: https://r.myreg.io
          OCI_NAMESPACE: myorg/myrepo
          OCI_USERNAME: ${{ secrets.OCI_USERNAME }}
          OCI_PASSWORD: ${{ secrets.OCI_PASSWORD }}
      - name: Upload test results zip as build artifact
        uses: actions/upload-artifact@master
        with:
          name: results
          path: /results
        if: always()
```
