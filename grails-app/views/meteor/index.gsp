<!DOCTYPE html>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <title>Todo</title>
  <script src="assets/jquery-1.11.0.min.js" type="text/javascript"></script>
  <script src="assets/can.custom.js" type="text/javascript"></script>
  <script src="assets/sockjs.js"></script>
  <script src="assets/stomp.js"></script>

  <script type="text/javascript">
    <g:each in="${domains}" var="domain">
    var ${domain.name}_changes = can.compute('');
    var ${domain.name} = can.Model({
      findAll: function(id)   {return $.get('${domain.name}.json/')},
      findOne: function(id)   {return $.get('${domain.name}.json/'+id)},
      create:  function(data) {return $.post('${domain.name}.json/', data)},
      update:  function(id)   {return $.ajax({type: 'PUT',    url: '${domain.name}.json/'+id })},
      destroy: function(id)   {return $.ajax({type: 'DELETE', url: '${domain.name}/'+id, contentType: 'application/json' })}
    }, {});
    </g:each>
  </script>
  <script type="text/javascript">
    var index = {scope: {}, events: {}};
  </script>
  <script src="assets/meteor.js" type="text/javascript"></script>
  <script type="text/javascript">
    can.Component.extend({
      tag: "index",
      template: can.view("assets/meteor.mustache"),
      scope: index.scope,
      events: index.events
    });

    $(document).ready(function() {
      var socket = new SockJS("stomp");
      var client = Stomp.over(socket);

      <g:if test="${domains}">
        client.connect({}, function() {
          <g:each in="${domains}" var="domain">
          client.subscribe("/topic/${domain.name}", function(message) {
            ${domain.name}_changes(${domain.name}_changes() + 1);
          });
          </g:each>
        });
      </g:if>
      $("body").html( can.view.mustache("<index></index>"));
    });
  </script>
</head>
<body></body>
</html>

