# == Class resin::config
#
# This class is called from resin
#
class resin::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # This template uses almost all class parameters.
  file { $resin::config_file:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0444',
    content => template($resin::config_template),
    require => Package[$resin::package_name],
  }

}
