# 1-install_a_package.pp

# Ensure pip3 is installed
package { 'python3-pip':
  ensure => installed,
}

# Install Flask 2.1.0 using pip3 as the provider
package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}
