# k8s_common profile

class profiles::k8s_common {
  include firewalld

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

  exec { 'swapoff':
    path    => '/sbin',
    command => 'swapoff -a'
  }

  class { 'selinux':
    mode => 'disabled',
  }

  $k8s_firewall_ports = ['8285', '8472']

  $k8s_firewall_ports.each |String $port| {
    firewalld_port {"k8s_firewall_${port}":
      ensure   => present,
      zone     => 'public',
      port     => $port,
      protocol => 'udp'
    }
  }

}
