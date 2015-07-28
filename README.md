# bern
simplistic cloud bot. Bern performs tasks for you. Now is logging hours.

# How can I use it?

Bern bot contains a ruby script that you can run every day or create a
background job that run for you at certain hour.

#### Requeriments

  SMTP SERVER, SET ENV VARS, NEWRELIC APP

#### locally

You need to setup a smtp server and set the env vars

#### HOST REMOTELY

You need to get your smtp servers setting and set as env vars


#### Logger

Bern performs a task that logs hours in redmin therefore you need the
settings and payload of your **REDMINE SERVER

#### ENV VARS

  SMTP SERVER:
  ```ruby
  SENDGRID_PASSWORD:     smtp password
  SENDGRID_USERNAME:     smtp username
  SMTP_DEVELIVERY_EMAIL: notification email
  SMTP_DOMAIN:           smtp server domain
  SMTP_HOST_EMAIL:       host email, your server email for example 'username@bern.heroku.com'
  SMTP_PORT:             smtp port
  SMTP_SERVER:           smtp host
  ```

  REDMINE:
  ```ruby
  ACTIVITY_ID:           redmine activity id
  HOURS:                 number of hours
  ISSUE_ID:              issue id
  THIRD_PARTY_KEY:       redmine api key
  THIRD_PARTY_URL:       redmine url
  ```
  NEWRELIC:
  ```ruby
  NEW_RELIC_APP_NAME:    newrelic app name
  NEW_RELIC_LICENSE_KEY:
  NEW_RELIC_LOG:
  ```

#### HOW AM I USING?

I've uploaded bern to a heroku app. I've added the scheduler addon and setup to
run every day the script `redmine_log_hours`

I've also added newrelic and send grid addons

Heroku automatically setup for you all env vars as bern requires, then I've
just setup the env vars for redmine.

Bern is logging to redmine using the [redmine api](http://www.redmine.org/projects/redmine/wiki/Rest_api)

#### Can I collaborate to bern cloud bot?

Yes you can. Please fork this repo add and test your integration and send me
the pull request.



