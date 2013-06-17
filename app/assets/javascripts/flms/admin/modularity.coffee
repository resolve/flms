#= require jquery
#= require_self
#= require ./tools/string_tools

# The Modularity framework written specificially for CoffeeScript.
#
# Use UglifyJS (http://github.com/mishoo/UglifyJS) for compression.
#
# Please see https://github.com/kevgo/modularity for more information on Modularity,
# and https://github.com/kevgo/modularity-rails for Rails integration.


@modularity = {

  # Checks whether the given condition is true.
  # Shows an alert with the given message if not.
  assert: (condition, message) ->
    if !condition or condition?.length == 0
      alert message
      return false
    true


  # GLOBAL EVENTS.

  # Subscribes to the given global event,
  # i.e. calls the given function when the given global event type happens.
  bind_global_event: (event_type, callback) ->
    return unless modularity.assert typeof event_type == 'string', "modularity.bind_global_event: parameter 'event_type' is empty"
    return alert "modularity.bind_global_event: parameter 'callback' must be a function, #{callback} (#{typeof callback}) given." unless typeof callback == 'function'
    modularity.global_event_container().bind event_type, callback

  # Fires the given global event with the given data payload.
  fire_global_event: (event_type, data) ->
    modularity.assert event_type, 'Module.fire_global_event: You must provide the event type to fire.'
    return alert("Module.fire_global_event: Event type must be a string, #{event_type} (#{typeof event_type}) given.") unless typeof event_type == 'string'
    modularity.global_event_container().trigger event_type, data ?= []

  # Returns the DOM object that is used to fire global events on.
  global_event_container: -> modularity.global_event_container_cache or= $(window)
}
@modularity.bindGlobalEvent = @modularity.bind_global_event
@modularity.fireGlobalEvent = @modularity.fire_global_event


class @modularity.Module

  # The container variable is required. Provide 'testing' in tests.
  constructor: (container) ->
    container = $(container) if (typeof container == 'string') and container != 'testing'
    @container = container

    return alert 'Error in Module constructor: No container given.' unless @container?
    if container != 'testing'
      return alert 'Error in Module constructor: The given container must be a jQuery object.' unless typeof container.jquery == 'string'
      return alert "Error in Module constructor: The given container ('#{container.selector}') is empty." unless container? and container.length > 0
      return alert "Error in Module constructor: The given container ('#{container.selector}') has more than one element." unless container? and container.length == 1


    # Attach mixins.
    if @mixins?
      for mixin_data in @mixins

        # Attach all properties from mixin to the prototype.
        for methodName, method of mixin_data.mixin
          do (methodName, method) => unless @[methodName]
            @[methodName] = => method.apply(@, arguments)

        # Call constructor function from mixin.
        mixin_data.mixin?.constructor?.apply(@, arguments)


  # Runs the given query within the container element.
  $: (query) ->
    @container.find query


  # MODULE EVENTS.

  # Automatically binds events to member elements.
  autobind: ->
    my_fields = []
    my_callbacks = []
    for element of @
      switch typeof @[element]
        when 'object'
          my_fields.push element
        when 'function'
          my_callbacks.push(element) if modularity.string_starts_with element, 'on_'
    for field in my_fields
      for callback in my_callbacks
        if modularity.string_starts_with callback, "on_#{field}_"
          event_name = callback.substring 4 + field.length
          @[field].on event_name, @[callback]
    false


  # Calls the given function when this widget fires the given local event.
  on: (event_type, callback) =>
    return unless modularity.assert typeof event_type == 'string', "Module.bind_event: parameter 'event_type' is empty"
    return alert "Module.bind_event: parameter 'callback' must be a function, #{callback} (#{typeof callback}) given." unless typeof callback == 'function'
    @container.bind event_type, callback
  bindEvent: Module::bind_event
  bind_event: Module::bind_event


  # Fires the given local event with the given data payload.
  trigger: (event_type, data) =>
    modularity.assert event_type, 'Module.fire_event: You must provide the event type to fire.'
    return alert("Module.fire_event: Event type must be a string, #{event_type} (#{typeof event_type}) given.") unless typeof event_type == 'string'
    @container.trigger event_type, data ?= {}
  fireEvent: Module::fire_event
  fire_event: Module::fire_event


  # Hides this module.
  hide: ->
    @container.hide()
    @container.trigger 'hide'


  # mixin = constructor of Draggable
  # self = Card
  @mixin: (mixin, p...) ->
    alert("mixin not found") unless mixin
    @prototype.mixins or= []
    @prototype.mixins.push({mixin: mixin, params: p})


  # Shows this module.
  show: ->
    @container.show()
    @container.trigger 'show'


  # Returns whether this module is currently visible.
  visible: ->
    @container.is ':visible'
