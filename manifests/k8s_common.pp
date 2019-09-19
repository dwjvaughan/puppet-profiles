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
    unless    => 'test -d /proc/sys/net/bridge',
  } -> file_line { '/etc/sysctl.conf bridge-nf-call-iptables':
    path  => '/etc/sysctl.conf',
    line  => 'net.bridge.bridge-nf-call-iptables=1',
    match => 'net.bridge.bridge-nf-call-iptables\s*=',
  } -> exec { 'sysctl_refresh':
    path      => ['/usr/sbin', '/sbin', '/usr/bin', '/bin'],
    command   => 'sysctl -p /etc/sysctl.conf',
    logoutput => 'on_failure',
  }

  package { [ 'kubectl', 'kubeadm', 'docker' ]:
    ensure  => 'installed',
    require => Yumrepo['kubernetes'],
  }

}
