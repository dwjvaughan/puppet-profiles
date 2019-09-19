# k8s_master profile

class profiles::k8s_master {
  include firewalld

  $k8s_firewall_ports = ['6443', '2379-2380', '10250-10252', '10255']

  $k8s_firewall_ports.each |String $port| {
    firewalld_port {"k8s_firewall_${port}":
      ensure   => present,
      zone     => 'public',
      port     => $port,
      protocol => 'tcp'
    }
  }

  # firewalld_port { 'k8s_2379_tcp':
  #   ensure   => present,
  #   zone     => 'public',
  #   port     => 2379,
  #   protocol => 'tcp'
  # }

  # firewalld_port { 'k8s_2380_tcp':
  #   ensure   => present,
  #   zone     => 'public',
  #   port     => 2380,
  #   protocol => 'tcp'
  # }

  # firewalld_port { 'k8s_10250_tcp':
  #   ensure   => present,
  #   zone     => 'public',
  #   port     => 10250,
  #   protocol => 'tcp'
  # }

  # firewalld_port { 'k8s_10251_tcp':
  #   ensure   => present,
  #   zone     => 'public',
  #   port     => 10251,
  #   protocol => 'tcp'
  # }

  # firewalld_port { 'k8s_10252_tcp':
  #   ensure   => present,
  #   zone     => 'public',
  #   port     => 10252,
  #   protocol => 'tcp'
  # }

  # firewalld_port { 'k8s_10255_tcp':
  #   ensure   => present,
  #   zone     => 'public',
  #   port     => 10255,
  #   protocol => 'tcp'
  # }
}
