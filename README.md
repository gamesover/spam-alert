# Spam Alert

Simple Spam Alert system based on https://honeybadger.notion.site/honeybadger/Take-home-project-for-Software-Developer-position-2023-fee9be3cd8454e1fb61e53f0172ff2e8

## Description

This is a simple Ruby on Rails application to receive api call.

It could check whether passed message is spam
* if the message is spam, send notification to slack channel and api return true
* if the message is not spam, just api return false

## Getting Started

### Dependencies

* Ruby: 3.0.0
* Rails: 7.0.4

### Start app locally

* Install the above dependencies
* run `bundle exec rails server`

### Deployment

* The attached example `Dockerfile` and `docker-compose.yml` are able to deploy some cloulds who can run based on docker image
* Step-by-step
```
docker compose build
docker compose push
```

## Drawbacks

* Slack related rspec are skipped, to do it correctly, it should use `VCR`
* Model are skipped
* Did not test really to slack. For prod purpose, it must be tested in real slack channel
* Depends on deployment system, docker image is okay for some docker based cloud. But it won't apply to all systems.
