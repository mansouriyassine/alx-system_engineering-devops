

fest for setting up Nginx with a custom HTTP header

exec { 'system_update':
  command => '/usr/bin/apt-get update',
  path    => ['/bin', '/usr/bin'],
  before  => Exec['nginx_installation'],
}

exec { 'nginx_installation':
  command => '/usr/bin/apt-get install -y nginx',
  path    => ['/bin', '/usr/bin'],
  unless  => '/usr/bin/dpkg -l | grep nginx',
  before  => Exec['header_setup'],
}

exec { 'header_setup':
  command     => "/bin/sed -i '/^\tinclude \/etc\/nginx\/sites-enabled\/\*/a \\tadd_header X-Served-By \"\$HOSTNAME\";' /etc/nginx/nginx.conf",
  path        => ['/bin', '/usr/bin'],
  refreshonly => true,
  subscribe   => Exec['nginx_installation'],
  before      => Exec['nginx_service_restart'],
}

exec { 'nginx_service_restart':
  command     => '/usr/sbin/service nginx restart',
  path        => ['/bin', '/usr/bin', '/sbin'],
  refreshonly => true,
  subscribe   => Exec['header_setup'],
}
