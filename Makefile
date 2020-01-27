.PHONY: run
run:
	docker build . -t oci-test-action:dev && docker run --rm oci-test-action:dev