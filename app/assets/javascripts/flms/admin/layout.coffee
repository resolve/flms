$ ->
  setTimeout remove_flash, 1500


# Fades out the flash messages.
remove_flash = ->
  $('.flash').fadeOut 1000, ->
    $('.flash').remove()
