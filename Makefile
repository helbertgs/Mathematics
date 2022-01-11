clean:
	@find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch
	@rm -rf .build/
	@rm -rf .swiftpm/

build:
	@swift build

tests:
	@swift tests