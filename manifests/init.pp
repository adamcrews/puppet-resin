# == Class: resin
#
# Full description of class resin here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class resin (
  $package_name   = $resin::params::package_name,
  $package_ensure = $resin::params::package_ensure,

  $service_name   = $resin::params::service_name,
  $service_ensure = $resin::params::service_ensure,
  $service_enable = $resin::params::service_enable,
  $service_manage = $resin::params::service_manage,

  $resin_root     = $resin::params::resin_root,

  $config_file        = $resin::params::config_file,
  $config_template    = $resin::params::config_template,
  $document_directory = $resin::params::document_directory,
  $stdout_log         = $resin::params::stdout_log,
  $access_log         = $resin::params::access_log,
  $extra_log          = undef,

  $dependency_check_interval = $resin::params::dependency_check_interval,
  $http_address              = $resin::params::http_address,
  $http_port                 = $resin::params::http_port,

  $java_xms                  = $resin::params::java_xms,
  $java_xmx                  = $resin::params::java_xmx,
  $java_xmn                  = $resin::params::java_xmn,
  $java_xss                  = $resin::params::java_xss,

  $memory_free_min           = $resin::params::memory_free_min,
  $thread_max                = $resin::params::thread_max,
  $socket_timeout            = $resin::params::socket_timeout,
  $keepalive_max             = $resin::params::keepalive_max,
  $keepalive_timeout         = $resin::params::keepalive_timeout,

) inherits resin::params {

  validate_string($package_name)
  validate_re($package_ensure, [ '^absent', '^present', '^latest' ])

  validate_string($service_name)
  validate_re($service_ensure, [ '^stopped', '^running' ])
  validate_bool($service_enable)
  validate_bool($service_manage)

  validate_absolute_path($resin_root)
  
  validate_absolute_path($config_file)
  validate_string($config_template)
  validate_absolute_path($document_directory)
  validate_absolute_path($stdout_log)
  validate_absolute_path($access_log)

  if ( ! is_integer($dependency_check_interval) ) {
    fail("Error: dependency_check_interval should be an integer not ${dependency_check_interval}")
  }

  if ( ! ( is_domain_name($http_address) or is_ip_address($http_address) or ($http_address == '*') ) ) {
    fail("Error: http_address should be a domain name, ipaddress or '*' not $http_address")
  }

  if ( ! is_integer($http_port) ) {
    fail("Error: http_port should be a port number not ${http_port}")
  }

  if ( ! is_integer($java_xms) ) {
    fail("Error: java_xms should be an integer not ${java_xms}")
  }

  if ( ! is_integer($java_xmx) ) {
    fail("Error: java_xmx should be an integer not ${java_xmx}")
  }

  if ( ! is_integer($java_xmn) ) {
    fail("Error: java_xmn should be an integer not ${java_xmn}")
  }

  if ( ! is_integer($java_xss) ) {
    fail("Error: java_xss should be an integer not ${java_xss}")
  }

  if ( ! is_integer($memory_free_min) ) {
    fail("Error: memory_free_min should be an integer not ${memory_free_min}")
  }
  
  if ( ! is_integer($thread_max) ) {
    fail("Error: thread_max should be an integer not ${thread_max}")
  }

  if ( ! is_integer($socket_timeout) ) {
    fail("Error: socket_timeout should be an integer not ${socket_timeout}")
  }

  if ( ! is_integer($keepalive_max) ) {
    fail("Error: keepalive_max should be an integer not ${keepalive_max}")
  }

  if ( ! is_integer($keepalive_timeout) ) {
    fail("Error: keepalive_timeout should be an integer not ${keepalive_timeout}")
  }

  class { 'resin::install': } ->
  class { 'resin::config': } ~>
  class { 'resin::service': } ->
  Class['resin']
}
