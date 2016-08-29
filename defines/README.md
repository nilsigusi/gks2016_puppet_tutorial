# Defined resource types

Defined resource types (also called defined types or defines) are blocks of Puppet code that can be evaluated multiple times with different parameters. Once defined, they act like a new resource type: you can cause the block to be evaluated by declaring a resource of that new resource type.

Defines can be used as simple macros or as a lightweight way to develop fairly sophisticated resource types.

```
define hello_define ($content_variable) {
  file {"$title":
    ensure  => file,
    content => $content_variable,
  }
}
```

---

## A usage example

```
class hello_define {
    define hello_define ($content_variable) {
      file {"$title":
        ensure  => file,
        content => $content_variable,
      }
    }

    hello_define {'/tmp/hello_define1':
      content_variable => "Hello World. This is first define\n",
    }

    hello_define {'/tmp/hello_define2':
      content_variable => "This is my second define. Greeting from soivi.net\n",
    }
}
```

---
