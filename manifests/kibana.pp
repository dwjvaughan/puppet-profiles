# Kibana profile

class profiles::kibana {
  include elastic_stack::repo
  include kibana
  include firewalld

  firewalld_port { 'Open Kibana port':
    ensure   => present,
    zone     => 'public',
    port     => 5601,
    protocol => 'tcp',
  }
}
