class myhttp(
  $port = 8081,
  $special_name = "Hero",
  $drinks = [],
)
{

   package{'httpd':
       ensure => 'installed',
   }

   service{'httpd':
       ensure  => 'running',
       require => Package['httpd'],
   }

   file { '/etc/httpd/conf.d/welcome.conf':
       content => template('myhttp/welcome.conf.erb'),
       mode    => '0644',
       notify  => Service['httpd'],
   }

   file { '/var/www/html/index.html':
       content => template('myhttp/index.html.erb'),
       mode    => '0644',
   }

}
