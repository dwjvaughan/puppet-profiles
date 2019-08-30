# Elasticsearch

class profiles::elasticsearch {
  include elastic_stack::repo
  include elasticsearch

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
