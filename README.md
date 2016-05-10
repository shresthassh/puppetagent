# puppetagent

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppetagent](#setup)
    * [What puppetagent affects](#what-puppetagent-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppetagent](#beginning-with-puppetagent)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Takes smart class parameter values and makes puppet.conf file similar across all servers.
Works with RHEL6/7 and AIX.

## Module Description

This modules have template for RHEL6/7 and AIX.
Smart class parameters that can be changed:
  pluginsync = 'true',
  ca_server = 'puppet_ca_server',
  server = 'puppet_server',
  environment = 'Library',
  runinterval = '30m',
  ignoreschedules = 'false',

## Setup

### What puppetagent affects

This will replace /etc/puppet/puppet.conf file with template with above smart class parmeters values that can be changed.


## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.


## Limitations

On RHEL 6, if the changes are replace on puppet.conf with template and smart class parameters, notify to restart service puppet results in error.
# service puppet status
puppet dead but pid file exists

As a workaround, /etc/puppet/puppet_restart.sh will be created with service puppet stop/start.

## Development

Will consider fix/performace/add lines in template/more functions.

