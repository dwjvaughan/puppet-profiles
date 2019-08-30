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
}
