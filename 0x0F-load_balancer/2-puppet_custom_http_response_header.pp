# This is for task 2. Puppet manifest for configuring Nginx with a custom HTTP header 'X-Served-By'

class nginx_configuration {
  package { 'nginx':
    ensure => present,
    before => File['/var/www/html/index.nginx-debian.html'],
  }

  file { '/var/www/html/index.nginx-debian.html':
    ensure  => file,
    content => "Hello World!\n",
  }

  exec { 'create_custom_404':
    command => 'echo "Ceci n\'est pas une page" > /usr/share/nginx/html/custom_404.html',
    path    => ['/bin', '/usr/bin'],
    creates => '/usr/share/nginx/html/custom_404.html',
    require => Package['nginx'],
  }

  exec { 'nginx_server_name':
    command => "sed -i '/server_name _;/a \\\trewrite ^\\/redirect_me https:\\/\\/github.com\\/mansouriyassine permanent;\\n\\terror_page 404 \\/custom_404.html;\\n\\tlocation = \\/custom_404.html {\\n\\t\\troot \\/usr\\/share\\/nginx\\/html;\\n\\t\\tinternal;\\n\\t}' /etc/nginx/sites-available/default",
    path    => ['/bin', '/usr/bin'],
    unless  => "grep -q 'rewrite ^/redirect_me https://github.com/mansouriyassine permanent;' /etc/nginx/sites-available/default",
    notify  => Service['nginx'],
  }

  exec { 'add_custom_header':
    command => "sed -i '/http {/a \\\tadd_header X-Served-By $HOSTNAME;' /etc/nginx/nginx.conf",
    path    => ['/bin', '/usr/bin'],
    unless  => "grep -q 'add_header X-Served-By $HOSTNAME;' /etc/nginx/nginx.conf",
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['/var/www/html/index.nginx-debian.html'],
  }
}

include nginx_configuration
