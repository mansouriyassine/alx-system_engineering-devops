#!/usr/bin/pup
# Install the 2.1.0 of flask
package {'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}
