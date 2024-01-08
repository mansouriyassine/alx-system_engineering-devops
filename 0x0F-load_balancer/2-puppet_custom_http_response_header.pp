# This is for task 2. Puppet manifest for configuring Nginx with a custom HTTP header 'X-Served-By'
class nginx_configuration {

  # Ensures Nginx is present on the server
  package { 'nginx':
    ensure => present,
  }

  # Creates a simple index.html page
  file { '/var/www/html/index.nginx-debian.html':
    ensure  => file,
    content => "Hello World!\n",
    require => Package['nginx'],
  }

  # Creates a custom 404 error page
  file { '/usr/share/nginx/html/custom_404.html':
    ensure  => file,
    content => "Ceci n'est pas une page", 
    require => Package['nginx'],
  }

  # Adds a rewrite rule for redirecting a specific path
  exec { 'nginx_rewrite_redirect':
    command => "sed -i '/server_name _;/a \\\trewrite ^/redirect_me https://github.com/mansouriyassine permanent;' /etc/nginx/sites-available/default",
    path    => ['/bin/', '/usr/bin/', '/sbin/' ],
    unless  => 'grep -q "rewrite ^/redirect_me" /etc/nginx/sites-available/default',
    notify  => Service['nginx'], 
  }

  # Adds a custom error page directive
  exec { 'nginx_error_page':
    command => "sed -i '/server_name _;/a \\\terror_page 404 /custom_404.html;' /etc/nginx/sites-available/default",
    path    => ['/bin/', '/usr/bin/', '/sbin/' ],
    unless  => 'grep -q "error_page 404 /custom_404.html" /etc/nginx/sites-available/default',
    notify => Service['nginx'],
  }

  # Sets up a location block for the custom 404 page
  exec { 'nginx_custom_404_location':
    command => "sed -i '/error_page 404 \/custom_404.html;/a \\\tlocation = /custom_404.html {\\n\t\troot /usr/share/nginx/html;\\n\t\tinternal;\\n\t}' /etc/nginx/sites-available/default",
    path   => ['/bin/', '/usr/bin/', '/sbin/' ],
    unless => 'grep -q "location = /custom_404.html" /etc/nginx/sites-available/default',
    notify => Service['nginx'],
  }

  # Adds the custom 'X-Served-By' header to the Nginx configuration
  exec { 'add_custom_header':
    command => 'sed -i "/http {/a \\\tadd_header X-Served-By \$HOSTNAME;" /etc/nginx/nginx.conf', 
    path    => ['/bin/', '/usr/bin/', '/sbin/'],
    unless  => 'grep -q "add_header X-Served-By" /etc/nginx/nginx.conf',
    notify  => Service['nginx'],
  }

  # Ensures that the Nginx service is running and enabled on boot
  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => [Package['nginx'], 
                File['/var/www/html/index.nginx-debian.html'],
                File['/usr/share/nginx/html/custom_404.html']] 
  }

}

include nginx_configuration
