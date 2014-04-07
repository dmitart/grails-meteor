package org.grailsmeteor

import grails.rest.Resource

class MeteorController {
  def grailsApplication

  def index() {
    [domains : grailsApplication.getDomainClasses().findAll{ it.clazz.getAnnotations().find{ it.annotationType() == Resource.class } }]
  }
}
