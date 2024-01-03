# Nginx - Puppet manifest to install and configure Nginx with a redirect
class nginx {
  
  package { 'nginx':
    ensure => present,
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    require   => Package['nginx'],
    subscribe => File['/etc/nginx/sites-available/default'],
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => template('nginx/default.erb'),
    notify  => Service['nginx'],
    require => Package['nginx'],
  }

  file { '/var/www/html/custom_404.html':
    ensure  => file,
    content => 'Ceci n\'est pas une page',
    require => Package['nginx'],
  }

  file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello World!',
    require => Package['nginx'],
  }
}

include nginx
