# == Class resin::service
#
# This class is meant to be called from resin
# It ensure the service is running
#
class resin::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $resin::service_manage { 
    service { $resin::service_name:
      ensure     => $resin::service_ensure,
      enable     => $resin::service_enable,
      hasstatus  => true,
      hasrestart => true,
      require    => Package[$resin::package_name],
    }
  }
}
