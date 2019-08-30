# Elasticsearch

class profiles::elasticsearch {
  include elastic_stack::repo
  include elasticsearch
  include firewalld

  firewalld_port { 'Open Elasticsearch port':
    ensure   => present,
    zone     => 'public',
    port     => 9200,
    protocol => 'tcp',
  }

  elasticsearch::instance { $::hostname:
    config => {
      'network.host' => '0.0.0.0'
    }
  }
}
