# Install and config the nginx
package { 'nginx':
  ensure => installed,
}

# Create the 'Hello World!' index.html page
file { '/var/www/html/index.html':
  ensure  => file,
  content => "Hello World!\n",
  require => Package['nginx'],
}

# Ensure the custom Nginx server block configuration for redirect
file_line { 'nginx_redirect':
  ensure  => present,
  path    => '/etc/nginx/sites-available/default',
  after   => 'server_name _;',
  line    => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
  match   => '^rewrite ^/redirect_me',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure the Nginx service is running
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
