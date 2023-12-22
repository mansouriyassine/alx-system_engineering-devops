#!/usr/bin/puppet apply
# Installs Flask version 2.1.0 using pip3. Ensures python3-pip is installed.

package { 'python3-pip':
  ensure => installed,
}

package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['python3-pip'],
}
