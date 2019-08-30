# Elasticsearch

class profiles::elasticsearch {
  include elastic_stack::repo
  include elasticsearch
  include firewalld

  # firewalld_port { 'Open Elasticsearch port':
  #   ensure   => present,
  #   zone     => 'public',
  #   port     => 9200,
  #   protocol => 'tcp',
  # }

  elasticsearch::instance { $::hostname:
    config      => {
      'xpack.monitoring.collection.enabled' => true
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
