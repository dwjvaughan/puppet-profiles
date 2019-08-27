# DNS Profile

class profiles::dns {
  include bind
  bind::server::conf { '/etc/named.conf':
  listen_on_addr    => [ 'any' ],
  listen_on_v6_addr => [ 'any' ],
  forwarders        => [ '8.8.8.8', '8.8.4.4' ],
  allow_query       => [ 'localnets' ],
  zones             => {
      'dwjv.net'                => [
        'type master',
        'file "dwjv.net"',
      ]
    },
  }
  bind::server::file { 'dwjv.net':
    source => 'puppet:///modules/profiles/dns/dwjv.net',
  }
}
