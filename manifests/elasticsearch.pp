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
    config      => {
      'network.host'                 => '0.0.0.0',
      'cluster.initial_master_nodes' => "${::hostname}-${::hostname}"
    },
    jvm_options => [
      '#PrintGCDetails',
      '#PrintGCDateStamps',
      '#PrintTenuringDistribution',
      '#PrintGCApplicationStoppedTime',
      '#Xloggc',
      '#UseGCLogFileRotation',
      '#NumberOfGCLogFiles',
      '#GCLogFileSize',
      '#XX:UseConcMarkSweepGC',
    ]
  }
}
