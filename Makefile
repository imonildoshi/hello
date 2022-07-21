start: tools env setup check test local

deploy: release build up

tools:
	cd tools && docker compose --env-file docker.env build && docker compose --env-file docker.env up -d
.PHONY: tools

tools_down:
	cd tools && docker compose --env-file docker.env down
.PHONY: tools_down

username = $(shell id -un)

env:
	cp env_examples/local.env.example .env
	cp env_examples/test.env.example test.env
	cp env_examples/prod.env.example prod.env
	cp env_examples/docker.env.example docker.env
	touch tools/docker.env && echo "USERNAME=${username}" > tools/docker.env
.PHONY: env

setup:
	source .env && mix local.rebar --force && mix local.hex --force
	source .env && mix deps.get
	source .env && mix ecto.setup
	source test.env && mix ecto.setup
	mix git_hooks.install
.PHONY: setup

check:
	mix compile --warnings-as-errors
	mix format --check-formatted
	mix credo --strict
	mix hex.audit
	mix sobelow -i Config.HTTPS
.PHONY: check

test:
	source test.env && mix test
	source test.env && mix coveralls.json
.PHONY: test

sld:
	mix docs
	mix ecto.gen.erd --output-path=sld/ecto_erd.dot
	dot -Tpng sld/ecto_erd.dot -o sld/erd.png
	mix ecto.gen.erd --output-path=sld/ecto_erd.dbml
.PHONY: sld

local:
	source .env && iex -S mix phx.server
.PHONY: local

build:
	docker-compose build

up:
	docker compose up -d

down:
	docker-compose down

release:
	MIX_ENV=prod mix local.rebar --force
	MIX_ENV=prod mix compile
	MIX_ENV=prod mix assets.deploy
	mix phx.gen.release
	source prod.env && mix release

start:
	_build/prod/rel/hello/bin/server
.PHONY: start

correct:
	source .env && mix git_hooks.install
