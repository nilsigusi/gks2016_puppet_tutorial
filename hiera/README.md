# Hiera

## Old style

here how we used to write modules

```ruby
# module "nginx", init.pp
class nginx(
  $port = "80"
){  # doing something, using $port
}

# module "ssh", init.pp
class ssh(
  $listenAddress = "0.0.0.0"
){  # doing something, using $port
}
```


---

## Old style 2

and assign classes to nodes

```ruby
# site.pp
node 'node_1.host.de'{
  class {"nginx":
    port => "81"
  }
}

node 'node_1.host.de'{
  class {"sshd":
    listenAddress = "127.0.0.1"
  }

  class {"nginx":
    port => "81"
  }
}
```

## HIERA!!! :)

Hiera separates data from modules...  and put them as `yaml` files

```ruby
class nginx{
  $port = hiera("nginx::port", '80')
}

class ssh{
  $listenAddress = hiera("ssh::listenAddress", '0.0.0.0')
}

node 'node_1.host.de'{
  include nginx
}

node 'node_1.host.de'{
  include sshd
  include nginx
}
```

```yaml
# node-1.host.de.yaml
nginx::port: 81

# node-1.host.de.yaml
nginx::port: 81
ssh::listenAddress: 127.0.0.1
```

---

## Even simpler

yes.. we can include classes right away in hiera yaml_s

```ruby
# site.pp
include(hiera_array("classes", []))

```

```yaml
# node-1.host.de.yaml
classes:
  - nginx
nginx::port: 81

# node-1.host.de.yaml
classes:
  - nginx
  - ssh
nginx::port: 81
ssh::listenAddress: 127.0.0.1
```

---

## Config Puppet Server

config puppet to use hiera

```
# puppet config
    hiera_config = $confdir/hiera.yaml
```

```
# hiera.yaml
---
:hierarchy:
 - fqdn/%{fqdn}
 - role/%{role}
 - common

:backends:
 - yaml

:yaml:
 :datadir: /etc/puppet/environments/%{environment}/hieradata

```

---

## Getting data

Before building the catalog, puppet would do:

 1. send facts to Puppet Master
 2. using this facts and build hiera data
 3. apply hiera data to manifest (set variable)
 4. build catalog

```
fact:              fqdn => "node-1.scc.kit.edu"

hiera looking for: fqdn/node-1.scc.kit.edu.yaml
(this is defined in hiera.yaml )
```

---

## Exercise

Let's use our `role` fact, and `sysadmin` module.

```ruby
class sysadmin{
  $permissions = hiera('sysadmin::permissions', 'no')

  notify{"My Permissions are: $permissions":}
  notify{"My role is: $::role":}
}
```

```bash
# hieradata/common.yaml
sysadmin::permissions: 'read'

# hieradata/role/admin.yaml
sysadmin::permissions: 'write'

```

change content of `/etc/role` and see what happening by `puppet agent -t`

---
