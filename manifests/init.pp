# == Class: puppetagent
#
# Full description of class puppetagent here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { puppetagent:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <shresthassh@gmail.com>
#
# === Copyright
#
# Copyright 2016 Subash Shrestha.
#
class puppetagent (
  $pagent_sync = 'true',
  $pagent_ca = 'puppet_ca_server',
  $pagent_server = 'puppet_server',
  $pagent_environment = 'Library',
  $pagent_interval = '30m',
  $pagent_ignoreschedules = 'false',
  $puppet_restart_file = '/etc/puppet/puppet_restart.sh',
  $puppet_restart_code = '/sbin/service puppet stop
/sbin/service puppet start
' ,

  ) {

  if $operatingsystem == 'RedHat' and $operatingsystemmajrelease == "6" {
    file { $puppet_restart_file:
      ensure => present,
      owner => root,
      group => root,
      mode => '0744',
      content => template("puppetagent/restart_puppet.erb"),
    }
    file {'/etc/puppet/puppet.conf':
      notify => Exec['puppet_rerun'],
      ensure => present,
      owner => root,
      group => root,
      mode => '0644',
      content => template("puppetagent/puppet_rhel.erb"),
    }
    exec {'puppet_rerun':
      command => "bash $puppet_restart_file",
      path => [ "/usr/bin", "/bin", "/usr/sbin", "/sbin" ],
      refreshonly => true,
    }
  }

  elsif $operatingsystem == 'RedHat' and $operatingsystemmajrelease == "7" {
    file {'/etc/puppet/puppet.conf':
      notify => Service['puppet'],
      ensure => present,
      owner => root,
      group => root,
      mode => '0644',
      content => template("puppetagent/puppet_rhel.erb"),
    }
    
    service {'puppet':
      ensure => running,
      enable => true,
      path => [ "/usr/bin", "/bin", "/usr/sbin", "/sbin" ],
      hasstatus => true,
      hasrestart => true,
    }
  }
 
  elsif $operatingsystem =='AIX' {
    file {'/etc/puppetlabs/puppet/puppet.conf':
      notify => Service['pe-puppet'],
      ensure => present,
      owner => root,
      group => system,
      mode => '0644',
      content => template("puppetagent/puppet_aix.erb"),
    }
    
    service {'pe-puppet':
      ensure => running,
      enable => true,
      path => [ "/opt/puppetlabs/puppet/bin", "/usr/bin", "/bin", "/usr/sbin", "/sbin" ],
      subscribe => File['/etc/puppetlabs/puppet/puppet.conf'],
    }
  }
  else {
    notice ("No standard puppet config for $operatingsystem on puppetagent module")
  }
}
