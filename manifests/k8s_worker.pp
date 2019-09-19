# k8s_worker profile

class profiles::k8s_worker {
  include firewalld

  $k8s_firewall_ports = ['6783', '10250', '10255', '30000-32767']

  $k8s_firewall_ports.each |String $port| {
    firewalld_port {"k8s_firewall_${port}":
      ensure   => present,
      zone     => 'public',
      port     => $port,
      protocol => 'tcp'
    }
  }

}
