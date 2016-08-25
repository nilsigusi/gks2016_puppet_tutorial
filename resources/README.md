# Puppet Custom Resources Types

`File`, `Package`, `Exec` - are all puppet resource types.

But I want to have my own!!

---

## Defining a type

You can use a `define` statement to create a new defined resource type.


```ruby
define mconfig(path, port) {
  file{"$path":
    content => inline_template("Use port: $port"),
  }
}
```

---

## Using it

```ruby
class sysadmin{

  $configs = hiera('sysadmin::configs', {})

  create_resources('sysadmin::mconfig', $configs)

  define mconfig...
}
```
