# Facter

https://docs.puppet.com/facter/

`FACTER` is Puppet’s cross-platform system profiling library. It discovers and reports per-node facts, which are available in your Puppet manifests as variables.

`FACTS` - `:key => :value` pairs, describing something

facter comes along puppet client. There are a number of facts (~90) coming with the package.

```bash
> facter

ipaddress => 141.5.6.111
ipaddress_ens192 => 141.5.6.111
ipaddress_lo => 127.0.0.1
swapfree => 637.84 MB
swapfree_mb => 637.84
swapsize => 1024.00 MB
...

```

---

![Puppet Facter](./puppet_facter.jpg)

 1. The client initiates the authentication request to the master.
 2. Puppet Master told client is legal and asks for facts
 3. Return facts to master
 4. Prepare and compile catalog
 5. Send catalog to clinet
 6. Execute catalog
 7. Init reporting system
 8. Report

---

## Using facts

for puppet facts are just __top scope__ variables

### using in manifests

```ruby
notify{"My Ip is $::ipaddress":
}

# output:
# Notify[My IP is: 131.169.217.69]/message: defined 'message' as 'My IP is: 131.169.217.69'
```

### using in templates

```ruby
## ssh configuration

# ListenAdress <%= @ipaddress %>

# output
# ListenAdress 131.169.217.69
```

---

## Custom facts

Sure you could create your custom facts.

```bash
# on the client
mkdir /var/lib/puppet/facts
vi /var/lib/puppet/facts/hardware_platform.rb

facter -p # display "puppet" facts
```

fact that retrieves hardware platform.

```ruby
Facter.add('hardware_platform') do # same as filename
  setcode do
    Facter::Core::Execution.exec('/bin/uname --hardware-platform')
  end
end
```

---

## Custom facts in modules

location inside module

```
lib/
 └── facter/
    └── hardware_platform.rb
```

the distribution is done via `pluginsync`. Facts(or any other plugin) would be always copied to the client system.
Even you are not using the module, which contains the custom fact. So custom facts should always produce a proper output.

on the clinet

```bash
puppet agent -t
facter -p
```

---

### Using other facts

we have those facts in the system:

```bash
operatingsystem => CentOS
operatingsystemmajrelease => 7
operatingsystemrelease => 7.2.1511
```

So lets bring them together

```ruby
Facter.add('complex') do # same as filename
  setcode do
    complex = Facter.value(:operatingsystem) + " " + Facter.value(:operatingsystemmajrelease) + " " + Facter.value(:operatingsystemrelease)
    complex
  end
end
```

```bash
puppet agent -t
facter -p
```
