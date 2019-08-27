# Duck DNS profile

class profiles::duck_dns {

  file { '/usr/local/bin/duck':
    content => 'puppet:///modules/profiles/duck_dns/duck',
    mode    => '0755'
  }

}
