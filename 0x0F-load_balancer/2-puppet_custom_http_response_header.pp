class nginx_custom_header {
  package { 'nginx':
    ensure => installed,
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    require   => Package['nginx'],
    subscribe => File['/etc/nginx/sites-available/default'],
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    require => Package['nginx'],
    content => template('nginx/default.erb'),
    notify  => Service['nginx'],
  }
  
  # This exec resource uses an inline template to add the custom header
  exec { 'insert_custom_header':
    command => "/bin/echo \"$(/bin/echo -e '\n\tadd_header X-Served-By ${::hostname};')\" | sudo /usr/bin/tee -a /etc/nginx/sites-available/default",
    unless  => "/bin/grep -q 'X-Served-By' /etc/nginx/sites-available/default",
    path    => ['/bin', '/usr/bin'],
    require => File['/etc/nginx/sites-available/default'],
    notify  => Service['nginx'],
  }
}

node default {
  include nginx_custom_header
}

