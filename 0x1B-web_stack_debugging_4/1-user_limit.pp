# Modifies the file descriptor limits for the 'holberton' user, increasing them to 88888 in the system's security configuration.
exec { 'change-os-configuration-for-holberton-user':
  command => "bash -c \"sed -iE 's/^holberton hard nofile \
5/holberton hard nofile 88888/' /etc/security/limits.conf; \
sed -iE 's/^holberton soft nofile \
4/holberton soft nofile 88888/' /etc/security/limits.conf\"",
  path    => '/usr/bin:/usr/sbin:/bin'
}
