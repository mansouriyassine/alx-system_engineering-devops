#!/usr/bin/pup
# Installs Flask version 2.1.0 using pip3. Ensures python3-pip is installed and pip is up-to-date.
package { 'python3-pip':
  ensure => installed,
}

exec { 'upgrade-pip':
  command => 'pip3 install --upgrade pip',
  path    => ['/usr/bin', '/bin'],
}

package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => [Package['python3-pip'], Exec['upgrade-pip']],
}
