# Client - Server

## Files on puppet Server

```bash
/etc/puppet/environment/$ENV/
- manifests
- modules
- hieradata

```

## modules dir

a place to store all the modules

```bash
modules/
  ssh
  httpd
  supadupa
```

---

## manifests

place for manifests

>in general - all .pp files are manifests. Do not mix this manifests with manifests inside modules!!!!

```bash
manifests/
  site.pp
```

```ruby
# site.pp
node 'node_1.host.de'{
  include sysadmin
}
node 'node_2.host.de'{
  include sysadmin
}
```

---

## Exercise

create a Puppet Module `sysadmin`

```
# init.pp
class sysadmin{
  notify {"I am a sysadmin":}
}
```

```
# site.pp

node 'gridkaschool01.desy.de'{
  include sysadmin
}
```

---

```
~/puppet/
  manifests/
    site.pp
       
  modules/
    sysadmin/
      manifests/
         init.pp
         # class sysadmin{}
         
  .git
```
