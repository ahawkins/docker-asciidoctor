#!/usr/bin/env bats

@test "can generate HTML output" {
	run docker run --rm -t -v "${FIXTURE_DIR}:/fixtures:ro" -v "${OUTPUT_DIR}:/out" "${DOCKER_IMAGE}" \
		asciidoctor -d book -b html5 -D /out /fixtures/sample.asciidoc
	[ $status -eq 0 ]
}

@test "can generate PDF output" {
	run docker run --rm -t -v "${FIXTURE_DIR}:/fixtures:ro" -v "${OUTPUT_DIR}:/out" "${DOCKER_IMAGE}" \
		asciidoctor -r asciidoctor-pdf -d book -b pdf -D /out /fixtures/sample.asciidoc
	[ $status -eq 0 ]
}

@test "can generate epub output" {
	run docker run --rm -t -v "${FIXTURE_DIR}:/fixtures:ro" -v "${OUTPUT_DIR}:/out" "${DOCKER_IMAGE}" \
		asciidoctor -r asciidoctor-epub3 -d book -b epub3 -D /out /fixtures/sample.asciidoc
	[ $status -eq 0 ]
}

@test "higlights code with pygments" {
	run docker run --rm -t -v "${FIXTURE_DIR}:/fixtures:ro" -v "${OUTPUT_DIR}:/out" "${DOCKER_IMAGE}" \
		asciidoctor -d book -b html -D /out /fixtures/pygments.asciidoc
	[ $status -eq 0 ]
}

@test "higlights code with coderay" {
	run docker run --rm -t -v "${FIXTURE_DIR}:/fixtures:ro" -v "${OUTPUT_DIR}:/out" "${DOCKER_IMAGE}" \
		asciidoctor -d book -b html -D /out /fixtures/coderay.asciidoc
	[ $status -eq 0 ]
}
