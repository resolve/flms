# Page controller for the 'edit' screen for pages.
class @PageEditPage extends modularity.Module

  constructor: ->
    super 'body'

    # The list of blocks.
    @block_list = new BlockList @$('.block_list')
    @block_list.on 'sorting_finished', @sorting_finished

    # The 'save' button.
    @save_button = @$('#save')
    @save_button.click @save_button_clicked

    @$('.switch').on 'switch-change', @active_switch_changed


  # Called when the 'active' checkbox of a block is changed.
  active_switch_changed: =>
    @save_button.fadeIn()


  # Called when the 'save' button is clicked.
  save_button_clicked: =>
    @save_changes_to_server()


  # Save the changes to the server.
  save_changes_to_server: ->
    $.ajax
      url: document.url
      method: 'PUT'
      contentType: 'application/json'
      data: JSON.stringify({block_data: @block_list.get_data()})
      success: =>
        @save_button.fadeOut()


  # Called when the user has changed the sorting of the blocks.
  sorting_finished: =>
    @save_button.fadeIn()

