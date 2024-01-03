# 7-puppet_install_nginx_web_server.pp
class nginx_install {

  # Ensure Nginx package is installed
  package { 'nginx':
    ensure => installed,
  }

  # Ensure Nginx service is running and enabled
  service { 'nginx':
    ensure => running,
    enable => true,
    require => Package['nginx'],
    subscribe => File['/etc/nginx/sites-available/default'],
  }

  # Serve a custom hello world page
  file { '/var/www/html/index.html':
    ensure  => present,
    content => "Hello World!\n",
    require => Package['nginx'],
  }

  # Custom 404 page content
  file { '/var/www/html/custom_404.html':
    ensure  => present,
    content => "Ceci n'est pas une page\n",
    require => Package['nginx'],
  }

  # Configure Nginx to serve the custom pages and setup redirection
  file { '/etc/nginx/sites-available/default':
    ensure  => present,
    content => template('nginx/default.conf.erb'),
    notify  => Service['nginx'],
  }
}

include nginx_install
