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

  sysctl::set { 'net.bridge.bridge-nf-call-iptables':
    value => 1
  }

  package { [ 'kubectl', 'kubeadm', 'docker' ]:
    ensure  => 'installed',
    require => Yumrepo['kubernetes'],
  }

}
