# Community Share

[![Build Status](https://travis-ci.org/chrislaskey/community-share.svg?branch=master)](https://travis-ci.org/chrislaskey/community-share)

> A multi-tenant SaaS application where communities can organize and share files between members

It includes tiered pricing and feature sets. And administrative tools for communities to control user levels.

## Application Features

For more information on the application and its features visit the Community Share website at [community-share.com](https://community-share.com).

### Demo

A [live demo](https://community-share.com#demo) is available. Or get more hands-on and [signing up](https://community-share.com#sign-up) for the free pricing tier.

## Technical Background

Community Share is built on [Ruby on Rails 5](http://rubyonrails.org/)

The application uses:

- [Paperclip](https://github.com/thoughtbot/paperclip)
- [Devise](https://github.com/plataformatec/devise)
- [Omniauth](https://github.com/omniauth/omniauth)
- [Omniauth Facebook](https://github.com/mkdynamic/omniauth-facebook)

The test suite uses:

- RSpec
- Rubocop
- Factory Girl
- Shoulda Matchers

## Infrastructure

- Amazon EC2 for compute
- Amazon S3 for file storage
- Facebook for user authentication
- Ansible for server configuration and code deployment

See the [Community Share Ansible repository](https://github.com/chrislaskey/community-share-ansible) for more details.
