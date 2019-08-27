# Duck DNS profile

class profiles::duck_dns {

  file { '/usr/local/bin/duck':
    source => 'puppet:///modules/profiles/duck_dns/duck',
    mode   => '0755'
  }

  cron::job { 'updatedns':
    minute      => '0,10,20,30,40,50',
    hour        => '*',
    date        => '*',
    month       => '*',
    weekday     => '*',
    user        => 'root',
    command     => '/usr/local/bin/duck >/dev/null 2>&1',
    description => 'Update Duck DNS',
  }

}
