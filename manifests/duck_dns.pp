# Duck DNS profile

class profiles::duck_dns {

  file { '/usr/local/bin/duck':
    source => 'puppet:///modules/profiles/duck_dns/duck',
    mode   => '0755'
  }

  cron::job { 'updatedns':
    minute      => '*',
    hour        => '*',
    date        => '*',
    month       => '*',
    weekday     => '*',
    user        => 'root',
    command     => '/usr/local/bin/duck',
    description => 'Update Duck DNS',
  }

}
