erltpl
========

It is a very simple module generator

Clone the repository, `cd` to it, execute following command and be happy:

```
sudo ln -s ./erltpl.erl /usr/bin
```

Now you can use `erltpl` to generate modules based on templates.

```
erltpl my_awesome_server gen_server
```

will create my_awesome_server.erl with basic gen_server code

Currently there are only 4 templates in /templates - you can do whatever you want with it: update, delete, create new templates etc.
available variables in templates are:

{{AUTHOR}} - defined in erltpl as -define(AUTHOR, <<"'Author name'">>

{{MODULE}} - module name