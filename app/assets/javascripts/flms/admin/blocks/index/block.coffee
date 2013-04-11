# A single block on the blocks index page.
class @Block extends modularity.Module

  constructor: ->
    super

    # The 'active' switch.
    @active_switch = @$('.switch')


  # Returns the id of this block.
  id: ->
    @container.data('block-id')


  # Returns whether this block is activated.
  active: ->
    @active_switch.bootstrapSwitch('status')


  # Returns the data for this block.
  get_data: ->
    {
      id: @id(),
      active: @active()
    }


