# Puppet manifest to configure Nginx with a custom HTTP header

class nginx_custom_header {
  package { 'nginx':
    ensure => installed,
  }

  file { '/var/www/html/index.nginx-debian.html':
    ensure  => file,
    content => "Hello World!\n",
    require => Package['nginx'],
  }

  file { '/usr/share/nginx/html/custom_404.html':
    ensure  => file,
    content => "Ceci n'est pas une page\n",
    require => Package['nginx'],
  }

  exec { 'nginx_rewrite_rule':
    command => "sed -i 's/server_name _;/server_name _;\\n\\trewrite ^\\/redirect_me https:\\/\\/github.com\\/ChidiChuks permanent;\\n\\n\\terror_page 404 \\/custom_404.html;\\n\\tlocation = \\/custom_404.html {\\n\\t\\troot \\/usr\\/share\\/nginx\\/html;\\n\\t\\tinternal;\\n\\t}/' /etc/nginx/sites-available/default",
    require => Package['nginx'],
  }

  exec { 'nginx_custom_header':
    command => "sed -i 's/include \\/etc\\/nginx\\/sites-enabled\\/*;/include \\/etc\\/nginx\\/sites-enabled\\/*;\\n\\tadd_header X-Served-By \"$HOSTNAME\";/' /etc/nginx/nginx.conf",
    require => Package['nginx'],
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Exec['nginx_custom_header'],
  }
}

include nginx_custom_header
