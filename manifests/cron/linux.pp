# manifests/cron/linux.pp 
class puppet::cron::linux inherits puppet::linux {

  include puppet::cron::base
  if !$puppet_config { $puppet_config = '/etc/puppet/puppet.conf' }
  if $puppet_http_compression { $puppet_http_compression_str = '--http_compression' }

  
  if !$puppet_crontime {
    $puppet_crontime_interval_minute = fqdn_rand(29)
    $puppet_crontime_interval_minute2 = inline_template('<%= 30+puppet_crontime_interval_minute.to_i %>')
    $puppet_crontime = "${puppet_crontime_interval_minute},${puppet_crontime_interval_minute2} * * * *"
  }

  File['/etc/cron.d/puppetd.cron']{
    source => undef,
    content => "#run puppet\n$puppet_crontime root output=\$(/usr/sbin/puppetd --onetime --no-daemonize --splay --config=/etc/puppet/puppet.conf --color false); ret=\$?; printf \"\\%s\" \"\$output\" | grep -E '(^err:|^alert:|^emerg:|^crit:)'; exit \$ret\n",
    before => Service['puppet'],
    ensure => present
  }
}
