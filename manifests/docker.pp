# Docker

class profiles::docker {

  yumrepo { 'docker-ce-stable':
    ensure   => 'present',
    name     => 'docker-ce-stable',
    descr    => 'Docker CE Stable - $basearch',
    baseurl  => 'https://download.docker.com/linux/centos/7/$basearch/stable',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'https://download.docker.com/linux/centos/gpg'
  }

  package { ['docker-ce', 'docker-ce-cli', 'containerd.io']:
    ensure  => 'installed',
    require => Yumrepo['docker-ce-stable'],
  }

}



