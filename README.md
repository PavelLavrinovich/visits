# Visits

## Getting Started

This guide outlines the steps needed to parse your log file and get great stat.

## Travis CI

[![Build Status](https://travis-ci.com/PavelLavrinovich/visits.svg?branch=master)](https://travis-ci.com/PavelLavrinovich/visits)

## Goal

There are some log file with the next format:

/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
/about/2 444.701.448.104
/help_page/1 929.398.951.889
/index 444.701.448.104
/help_page/1 722.247.931.582
/about 061.945.150.735
/help_page/1 646.865.545.408
/home 235.313.352.950

We need to get some stat with the most popular pages. It should look like this:
/home 90 visits /index 80 visits etc...
/about/2 8 unique views /index 5 unique views etc...

## Installation

Clone the repository

```sh
$ git clone git@github.com:PavelLavrinovich/visits.git
```

Cd to the project

```sh
$ cd visits
```

Run bundle

```sh
$ bundle
```

yay!

## Run app

Tested with ruby 2.7.1

```sh
$ ruby bin/stat.rb spec/fixtures/webserver.log
```

## Run spec

It's rspec, so, it's just

```sh
$ rspec
```

## Description

To achieve the goal there is should be some data structure with an efficient reading, but still it should be ordered. Relational database (Sqlite for now) has been chosen as a possible solution.

Three tables were implemented: `ips`, `url` and `visits`. Ips and urls are used as ids since they are uniq.
So the app just split every log line and store the url to the url.id and visits.url_id and every ip is stored at ip.id and visit.ip_id. With the ActiveRecord we can get count of all visits for the url with `url.visits.count` and all uniq views count with `url.ips.count`. There is also some denormalization to make ordering easier and reading faster, so these values are stored at `url.vistis_count` and `url.ips_count`. To prevent lots of inserts and updates `activerecord-import` is used. But still it does not support counter cache, so you should keep it in mind.

## TODO list

- use mysql/postresql instead of sqlite
- add batch processing
- check count queries
- use migrations instead of schema loading
- line validation looks too simple
- it might be great to have some factories as well
- get some sleep
