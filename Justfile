######################
# Development Workflow
######################

clean: ## cleans remnants of the build process
	. ./scripts/clean.sh dev

build: clean ## builds a local development Docker image
	. ./scripts/build.sh dev

start: ## starts a local development Docker container
	. ./scripts/start.sh dev

test: ## runs unit tests in a local development Docker container
	. ./scripts/start.sh test

serve-tests: ## runs unit tests on every file change
	find ./src | entr make test

format: ## runs the python Black formatter on all src files and test
	black src
