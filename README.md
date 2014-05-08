# README

Hubpanel is a simple NodeJS tool that enable you to send Github events
(through their webhooks feature) to a Mixpanel project.

## Use Cases

Test for yourself and share!

## Getting Started

### Setup

    cd hubpanel
    npm install -g nodemon
    npm install

### Launching

    MIXPANEL_PROJECT_ID=<enter yours> npm start

### Developping

    MIXPANEL_PROJECT_ID=<enter yours> nodemon app.coffee

### Deploying to Heroku

    heroku create <your hubpanel name>
    heroku config:set MIXPANEL_PROJECT_ID=<enter yours>
    git push heroku

### Configuring Github Webhooks

1. Connect to Github and edit settings for the repos you would like to track events.
2. Add a webook:
  - the payload URL should be `http(s)://your-setup-domain/github/events/username/repo`,
  - no secret supported yet,
  - select which types of events you want to track.