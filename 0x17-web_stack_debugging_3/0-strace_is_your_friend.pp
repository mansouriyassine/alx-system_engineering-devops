# 0.Strace is your friend

exec { 'Fix WordPress config typo':
  command  => 'sudo sed -i "s/.phpp/.php/" /var/www/html/wp-settings.php',
  provider => shell,
}
