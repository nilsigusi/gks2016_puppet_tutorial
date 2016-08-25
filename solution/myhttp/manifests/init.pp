class myhttp(
  $port = hiera('myhttp::port', 8080),
  $special_name = hiera('myhttp::special_name', 'noname'),
  $drinks = hiera('myhttp::drinks'),
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

   drinks_files{$drinks:}

   define drinks_files(){
       file { "/var/www/html/${name}.html":
          content => "<html><body>Here is your ${name}</body></html>",
       }
   }

}
