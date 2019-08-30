# Logstash

class profiles::logstash {
  include elastic_stack::repo
  include logstash
  include firewalld

  firewalld_port { 'Open Logstash port':
    ensure   => present,
    zone     => 'public',
    port     => 5044,
    protocol => 'tcp',
  }
}
