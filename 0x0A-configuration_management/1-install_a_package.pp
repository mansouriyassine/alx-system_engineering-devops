package { 'python3-pip':
  ensure => installed,
}

exec { 'upgrade-pip':
  command => 'pip3 install --upgrade pip',
  path    => ['/usr/bin', '/bin'],
  unless  => 'pip3 --version | grep "pip [latest version here]"',
  require => Package['python3-pip'],
}

package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Exec['upgrade-pip'],
}
