# k8s_common profile

class profiles::k8s_common {
  include firewalld
  include swap_file

  yumrepo { 'kubernetes':
    ensure   => 'present',
    name     => 'Kubernetes',
    descr    => 'Kubernetes El 7 - $basearch',
    baseurl  => 'https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64',
    gpgkey   => 'https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg',
    enabled  => '1',
    gpgcheck => '1',
    target   => '/etc/yum.repo.d/kubernetes.repo',
  }

  exec { 'load-bridge-netfilter':
    path      => ['/sbin', '/usr/sbin', '/bin', '/usr/bin'],
    command   => 'modprobe -b br_netfilter',
    logoutput => 'on_failure',
    unless    => 'test -d /proc/sys/net/bridge'
  } -> sysctl { 'net.bridge.bridge-nf-call-iptables':
    ensure => present,
    value  => 1
  }

  package { [ 'kubectl', 'kubeadm', 'docker' ]:
    ensure  => 'installed',
    require => Yumrepo['kubernetes'],
  } -> service { 'docker':
    ensure => 'running',
    enable => true
  } -> service { 'kubelet':
    ensure => running,
    enable => true
  }

swap_file::files { 'default':
  ensure   => absent,
}

}
