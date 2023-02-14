BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

branch:
	git checkout $(ARGS) > /dev/null 2>&1 || git checkout -b $(ARGS)
install:
	bundle install
lint:
	rubocop
pull:
	git pull origin $(BRANCH)
push:
	git push origin $(BRANCH)
test:
	rake test $(ARGS)
uncommit:
	git reset --soft HEAD^
upd:
	git merge master --no-edit

.PHONY: test
