# oci-test-action

## Example

```yaml
# Place in repo at .github/workflows/oci-test.yml
name: oci-test
on: push
jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - name: Run OCI Distribution Spec conformance tests
        uses: bloodorangeio/oci-test-action@master
        env:
          OCI_ROOT_URL: https://r.myreg.io
          OCI_NAMESPACE: myorg/myrepo
          OCI_USERNAME: ${{ secrets.OCI_USERNAME }}
          OCI_PASSWORD: ${{ secrets.OCI_PASSWORD }}
      - name: Upload test output zip as artifact
        uses: actions/upload-artifact@master
        with:
          name: results
          path: /results
        if: always()
```
