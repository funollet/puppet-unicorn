class unicorn (
    $app_path,
    $app_user = unicorn::params::app_user,
    $app_group = unicorn::params::app_group,
){
    
    # Newer Ubuntu releases have unicorn packaged. For Precise, install as a gem.
    package { 'unicorn':
        ensure   => present,
        provider => gem,
    }
    # A custom upstart script. unicorn process will be owned by $app_user, so he can manage
    # it when deploying code.
    file { 'unicorn_init':
        ensure  => present,
        path    => '/etc/init/unicorn.conf',
        content => template('unicorn/unicorn.upstart.conf.erb'),
        notify  => Service['unicorn'],
    }

    service { "unicorn":
        enable    => true,
        ensure    => running,
        hasstatus => true,
    }

    Package['unicorn'] -> File['unicorn_init'] -> Service['unicorn'] 
    File['unicorn.conf'] ~> Service['unicorn'] 
        
}
