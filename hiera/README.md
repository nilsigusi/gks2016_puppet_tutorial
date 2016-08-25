# Hiera

Hiera separates data from modules... It is an external place to specify data.

```ruby
# nginx class

class nginx{
  $port = hiera("nginx::port", '80')
}
```

```yaml
# hiera data

nginx::port: 81
```

---

## Config Puppet Server

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
# mkdir hieradata
# hieradata/common.yaml
sysadmin::permissions: 'read'

# hieradata/role/admin.yaml
sysadmin::permissions: 'write'

```

change content of `/etc/role` and see what happening by `puppet agent -t`

---
