# This class sets up the necessary ActiveRecord bits
# so storeconfigs works.

class puppet::puppetmaster::storeconfigs {
  include rails
  include mysql::server
  include mysql::client::ruby
}
