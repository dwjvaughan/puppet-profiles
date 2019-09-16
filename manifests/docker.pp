# Docker

class profiles::docker {

  yumrepo { 'docker-ce':
    ensure   => 'present',
    name     => 'Docker CE',
    descr    => 'Docker CE El 7 - $basearch',
    baseurl  => 'https://download.docker.com/linux/centos/docker-ce.repo',
    enabled  => '1',
    gpgcheck => '0',
    target   => '/etc/yum.repo.d/docker-ce.repo',
  }

  package { ['docker-ce', 'docker-ce-cli', 'containerd.io']:
    ensure  => 'installed',
    require => Yumrepo['docker-ce'],
  }

  # firewalld_port { 'Open Logstash port':
  #   ensure   => present,
  #   zone     => 'public',
  #   port     => 5044,
  #   protocol => 'tcp',
  # }
}



