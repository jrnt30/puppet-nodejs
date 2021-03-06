# Public: Install nodenv so nodejs versions can be installed
#
# Usage:
#
#   include nodejs

class nodejs(
  $nodenv_root    = $nodejs::params::nodenv_root,
  $nodenv_user    = $nodejs::params::nodenv_user,
  $nodenv_version = $nodejs::params::nodenv_version,
  $nodenv_env_root = $nodejs::params::nodenv_env_root,

  $nvm_root       = $nodejs::params::nvm_root
) inherits nodejs::params {
  require nodejs::nvm
  include nodejs::rehash

  file { "${nodejs::nodenv_env_root}/nodenv.sh":
    content=>template('nodejs/nodenv.sh.erb')
  }
  
  repository { "${nodejs::nodenv_root}":
    ensure => $nodenv_version,
    force  => true,
    source => 'wfarr/nodenv',
    user   => $nodenv_user
  }

  file { "${nodejs::nodenv_root}/versions":
    ensure  => directory,
    owner   => $nodenv_user,
    require => Repository[$nodenv_root]
  }
}
