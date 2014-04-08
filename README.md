grails-meteor
=============
This is Grails plugin that provides almost similar experience of using [MeteorJS](https://www.meteor.com/) in
[Grails](http://grails.org/) by leveraging Grails REST features with [CanJS](http://canjs.com/).
It is very thin and should not be used for production purposes.

# Prerequisites

Plugin relies on [websockets plugin](https://github.com/zyro23/grails-spring-websocket), so Grails 2.4 is required, as well as Tomcat 8.

# Setup

This plugin is not part of any repo, so to use it, you must checkout and build it manually.
```
git clone https://github.com/dmitart/grails-meteor.git grails-meteor
cd grails-meteor
grails maven-install
```

# Using

There is already example project at https://github.com/dmitart/grails-meteor-example, but you can reproduce one easily by folowing these steps.

## Create empty project
```
grails create-app grails-meteor-app
```

## BuildConfig.groovy
Update BuildConfig.groovy - set Tomcat 8 by removing tomcat plugin and adding tomcat8.
```
build ":tomcat8:8.0.1.1"
```

Remove cache plugin (it does not work with tomcat8).

Add grails-meteor
```
runtime ":grails-meteor:0.0.1.2"
```

## Domain resource

Create new domain class with resource annotation and map it to uri with same name, for example:
```
package test

import grails.rest.Resource

@Resource(uri = '/Todo')
class Todo {
  String description
  boolean done
}
```

## View

By default plugin loads template /grails-app/assets/htmls/meteor.mustache, so create it and add some code, for example:
```
<h1>test</h1>
<table>
{{#todos}}
  <tr>
    <td>{{description}}</td><td><input type="checkbox" can-value="done"></td>
    <td><input type="button" value="Delete" can-click="delete"></td>
    </tr>
{{/todos}}
</table>

Description
<input type="text" can-value="description">
<input type="button" can-click="add" value="Add">
```

## Controller

By default plugin uses template /grails-app/assets/javascripts/meteor.js, so create it and add some code, for example:
```
index.scope.todos = new Todo.List({});
index.scope.description = can.compute('');
index.scope.add = function() {
  new Todo({'description':this.description(), 'done':false}).save();
  this.description('');
};
index.scope.delete = function(todo) {
  todo.destroy();
};
index.events = {
  "{Todo_changes} change": function(){
    this.scope.attr('todos', new Todo.List({}));
  }
};
```

## Run

Now you can run your app
```
grails run-app
```

You can see results at http://localhost:8080/grails-meteor-app/meteor

