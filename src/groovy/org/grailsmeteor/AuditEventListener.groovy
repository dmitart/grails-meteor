package org.grailsmeteor

import org.hibernate.event.PostDeleteEvent
import org.hibernate.event.PostDeleteEventListener
import org.hibernate.event.PostInsertEvent
import org.hibernate.event.PostInsertEventListener
import org.hibernate.event.PostUpdateEvent
import org.hibernate.event.PostUpdateEventListener

class AuditEventListener implements PostInsertEventListener, PostDeleteEventListener, PostUpdateEventListener {
  def brokerMessagingTemplate

  @Override
  void onPostDelete(PostDeleteEvent event) {
    brokerMessagingTemplate.convertAndSend "/topic/${event.entity.class.simpleName}".toString(), "update"
  }

  @Override
  void onPostInsert(PostInsertEvent event) {
    brokerMessagingTemplate.convertAndSend "/topic/${event.entity.class.simpleName}".toString(), "update"
  }

  @Override
  void onPostUpdate(PostUpdateEvent event) {
    brokerMessagingTemplate.convertAndSend "/topic/${event.entity.class.simpleName}".toString(), "update"
  }
}
