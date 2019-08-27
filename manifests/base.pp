# Base class for all servers

class profiles::base (
  Optional[Hash]  $managed_users_hash     = undef,
  Optional[Hash]  $managed_ssh_keys_hash  = undef,
  $packages = [],
)
{
  include 'puppet'

  create_resources(user, $managed_users_hash)
  create_resources(ssh_authorized_key, $managed_ssh_keys_hash)

  if ($packages) {
    package { $packages:
      ensure   => 'installed',
      provider => 'yum',
    }
  }
}
