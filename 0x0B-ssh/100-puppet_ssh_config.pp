# 100-puppet_ssh_config.pp
# Puppet manifest to configure SSH client to use specific private key and refuse password authentication

# SSH configuration file
file { '/root/.ssh/config':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0600',
}

# Use of the private key ~/.ssh/school
file_line { 'Declare identity file':
  path => '/root/.ssh/config',
  line => 'IdentityFile /root/.ssh/school',
  match => '^IdentityFile',
  replace => true,
}

# Refusing password authentication
file_line { 'Turn off passwd auth':
  path => '/root/.ssh/config',
  line => 'PasswordAuthentication no',
  match => '^PasswordAuthentication',
  replace => true,
}
