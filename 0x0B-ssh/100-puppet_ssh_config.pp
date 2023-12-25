# Puppet manifest to configure SSH client to use specific private key and refuse password authentication

exec { 'echo "PasswordAuthentication no\nIdentityFile ~/.ssh/school" >> /etc/ssh/ssh_config':
        path    => '/bin/'
}
