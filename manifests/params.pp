# == Class resin::params
#
# This class is meant to be called from resin
# It sets variables according to platform
#
class resin::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $package_name   = 'resin'
      $service_name   = 'resin'
      $resin_root     = '/usr/local/resin'
      $config_file    = "${resin_root}/conf/resin.conf"
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  $package_ensure = 'present'

  $service_ensure = 'running'
  $service_enable = true
  $service_manage = true

  $config_template    = "${module_name}/resin.conf.erb"
  $document_directory = '/usr/local/resin/webapps'
  $stdout_log         = '/usr/local/resin/log/stdout.log'
  $access_log         = '/usr/local/resin/log/access.log'

  $dependency_check_interval = '2'
  $http_address              = '*'
  $http_port                 = '80'

  # Xms: initial heap size in Mb, 90% of ram unless otherwise specified
  # Xmx: Max heap size in Mb
  # Xmn: heap size for young generation in Mb
  # Xss: stack size for each thread in k, not Mb like the others
  $java_xms = floor( $::memorysize_mb * 0.90 )
  $java_xmx = floor( $::memorysize_mb * 0.90 )
  $java_xmn = floor( $java_xmx / 3 )
  $java_xss = 2048

  # If resin detects low memory from a memory leak, then resin will
  # gracefully restart if this threshold is crossed.
  $memory_free_min = 1

  # Max number of threads.  Should be a high number.
  $thread_max = 1024

  # Timeout in seconds
  $socket_timeout = 65

  $keepalive_max = 128

  # Timout for keepalive in seconds
  $keepalive_timeout = 15

}
