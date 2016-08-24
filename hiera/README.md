# Hiera

Hiera separates data from modules... It is an external place to specify data.
Hiera should handle __only plain data__. So modules should then only provide default values.

## How hiera works

Simple hiera config file is this one:

```
---
:hierarchy:
 - fqdn/%{fqdn}
 - common

:backends:
 - yaml

```

top lines have __higher__ priority.
If nothing found, a `common.yaml` file would be taken.

in the directory we have:

```
#./hira-data
└── fqnd
    └── mynode1.host.de
    └── mynode2.host.de
└── common.yaml




```

`fqdn` is a value of the fact from the node.


`FQDN` has a _

## Access hiera in puppet manifests

Hiera data files are `YAML` formated

```ruby
class myclass::{
  # required parameter
  $car1 = hiera('myclass::car1')

  # or with default value
  $car2 = hiera('myclass::car2', 'audi')

  notify{"cars: $car1, $car2":
  }
}
```

and the hiera file is:

```
myclass::car1: bmw
myclass::car2: opel

```
