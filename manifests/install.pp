# == Class resin::install
#
class resin::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { $resin::package_name:
    ensure => $resin::package_ensure,
  }

}
