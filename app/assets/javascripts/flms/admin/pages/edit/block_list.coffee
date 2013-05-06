# The list of blocks on a page.
class @BlockList extends modularity.Module

  constructor: ->
    super

    # Make block list sortable.
    $('.block_list').sortable(stop: @sorting_finished)
    $('.block_list').disableSelection()


  # Returns the data of the blocks.
  get_data: ->
    for tr in @$('tr')
      new Block($(tr)).get_data()


  # Called when the sorting is done.
  sorting_finished: =>
    @trigger 'sorting_finished'
