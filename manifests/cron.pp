# manifests/cron.pp

class puppet::cron inherits puppet {
  case $operatingsystem {
    linux: { include puppet::cron::linux }
    debian: { include puppet::cron::debian }
    openbsd: { include puppet::cron::openbsd }
    freebsd: { include puppet::cron::freebsd }
    default: { include puppet::cron::base }
  }
}
