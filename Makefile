BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

branch:
	git checkout $(ARGS) > /dev/null 2>&1 || git checkout -b $(ARGS)
install:
	bundle install
pull:
	git pull origin $(BRANCH)
push:
	git push origin $(BRANCH)
uncommit:
	git reset --soft HEAD^
upd:
	git merge master --no-edit
