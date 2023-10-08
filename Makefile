it:
	@echo "make [build|serve]"

build:
	docker buildx bake --load dev

serve:
	@test -n "$(DISC_HOST)" || (echo "DISC_HOST is not set"; exit 1)
	DISC_HOST=$(DISC_HOST) docker compose up
