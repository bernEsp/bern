# Bern
Bern is a simplistic cloud bot to perform annoying tasks such as logging hours in Redmine

# How can I use it?

Bern bot contains a ruby script that you can run every day or create a
background job that run for you at certain hour.

#### Requeriments

  SMTP SERVER, SET ENV VARS, NEWRELIC APP

#### locally

You need to setup a smtp server and set the env vars

#### HOST REMOTELY

You need to get your smtp servers settings and set as env vars

#### Logger

Bern performs a task to logs hours in redmine, therefore you need a little bit of
configuration and settings and payload of your **REDMINE SERVER

#### ENV VARS

  COMPANY HOLIDAYS:
  HOLIDAYS               list of holidays in this format 'yyyy-mm-dd' divided by comma


  SMTP SERVER:
  ```ruby
  SENDGRID_PASSWORD:     smtp password
  SENDGRID_USERNAME:     smtp username
  SMTP_DELIVERY_EMAIL:   notification email
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
  # optional
  COMMENTS               redmine random comments divided by semicolon
  ```
  NEWRELIC:
  ```ruby
  NEW_RELIC_APP_NAME:    newrelic app name
  NEW_RELIC_LICENSE_KEY:
  NEW_RELIC_LOG:
  ```

#### HOW AM I USING IT?

I've uploaded bern to a heroku app. I've added the scheduler addon and setup to
run every day the script `redmine_log_hours`

I've also added newrelic and send grid addons

Heroku automatically setup for you all env vars as bern requires, then I've
just setup the env vars for redmine.

Bern is logging to redmine using the [redmine api](http://www.redmine.org/projects/redmine/wiki/Rest_api)

#### Instructions for heroku (thanks @Ivanknmk)

1.  Fork and clone this repo
2.  Go to the root folder
3.  Install the heroku toolbelt (https://toolbelt.heroku.com/)
4.  Run this in the folder where you cloned the project to create a heroku app:
      `$ heroku login (and enter your heroku credentials)`

      `$ heroku create`
      
      `$ git push heroku master`
      
5.  Add New Relic:

      `$ heroku addons:create newrelic:wayne`

6.  Add a SMTP server:

      `$ heroku addons:create sendgrid:starter`

7.  Add a scheduler:

      `$ heroku addons:create scheduler:standard`

8.  Setup the env vars:

  Run heroku config. You should have already the SENDGRID_PASSWORD, SENDGRID_USERNAME & NEW_RELIC_LICENSE_KEY, so please set these variables:

  ```bash
      $ heroku config:set SMTP_DELIVERY_EMAIL=#{EMAIL_TO_RECEIVE_NOTIFICATIONS}
      
      $ heroku config:set SMTP_PORT=#{SMPT_PORT}
      
      $ heroku config:set SMTP_DOMAIN=#{HOST_DOMAIN}
      
      $ heroku config:set SMTP_SERVER=#{SMTP_ADDRESS}
      
      $ heroku config:set SMTP_HOST_EMAIL=#{YOUR_EMAIL}
      
      $ heroku config:set NEW_RELIC_APP_NAME=#{APP_NAME}

      $ heroku config:set ACTIVITY_ID=#{ID}
      
      $ heroku config:set HOURS={HOURS}
      
      $ heroku config:set ISSUE_ID=#{ISSUE_ID_IN_REDMINE}
      
      $ heroku config:set THIRD_PARTY_KEY=#{API_KEY}
      
      $ heroku config:set THIRD_PARTY_URL=#{REDMINE_URL}/time_entries.json
  ```

  If you find something like this #{SOMETHING_HERE} it means that a user input is required.
  So please look for the information required and substitute that string with the one you want.
    
9.  Go to https://dashboard.heroku.com/apps, find your app and click on it, look for the list of addons and open 'Heroku Scheduler'

10. Enter the name of ruby script 'redmine_log_hours' in the blank space, and set the frequency of your schedule.

11. Your app should be running in in heroku: app_name.heroku.com

#### Can I improve this awesome tool? Is it possible to collaborate?

Yes you can. Please fork this repo and send me the pull request.



