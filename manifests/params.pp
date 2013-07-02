class unicorn::params {
    if $::lsbdistcodename != 'precise' {
        fail('"unicorn" module only supports Ubuntu Precise')
    }

    $app_user = 'root'
    $app_group = 'root'
}
