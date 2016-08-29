# GKS 2016 - Puppet

## Facter

[Tutorial: Facter/Facts](./facter/README.md)

## Hiera

[Tutorial: Hiera](./hiera/README.md)

## Defines

[Tutorial: Defined resources](./defines/README.md)


---

## Task

Create a puppet module, which should do:

 * install and start http server on the node. Package name `httpd`
 * install `lynx` - a text browser for linux.
 * `/etc/httpd/conf.d/welcome.conf` should have this content. Configure this via puppet `File` resource from template.

```xml
Listen 1234

<VirtualHost *:1234>
    ServerName localhost
    DocumentRoot "/var/www/html"
</VirtualHost>

<Directory /var/www/html>
    AllowOverride None
    Require all granted
</Directory>

```
`1234` - is a port number to be changed, this should come from `hiera`. Note - httpd needs to be restarted, if configuration changes!

---

 * create the `index.html` in `DocumentRoot` of the server as a landing page.
 After rendering the HTML source code should be like this one

```html
<html>
<body>

<p>
Hello, My special name is: <b>ComupterHero.</b>
</p>

<p>
I am running on Linux <b>CentOs 7.1</b>
</p>

<p>
In the morning I am drinking:
<ul>
  <li><a href="coffee.html">Coffee</a></li>
  <li><a href="beer.html">Beer</a></li>
</ul>
</p>

</body>
</html>

```

---

* `ComupterHero` - coming from `hiera` as a parameter.
* `CentOs 7.1` - is a value of custom fact `full_os_name`
* `coffee.html` and `beer.html` should be generic links - pointing to files with a content:


```html
  <html><body>Here is your Coffee</body></html>
```

same for the Beer.

---

## hiera

the final hiera code should be:

```yaml
myhttp::port: 8080
myhttp::special_name: 'Computer Hero'
myhttp::drinks:
  - coffee
  - beer
```

---

## Test

load your page by:

 ```bash
   lynx http://localhost:8080
 ```

---

##  And a final task:

* Change the port in hiera to 8081
* add to the list of drinks: `juice`.
* Make a puppet run on the node and reload the page.

You should see the changes!!
