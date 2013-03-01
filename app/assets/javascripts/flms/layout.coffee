$ ->
  setTimeout remove_flash, 3000


# Fades out the flash messages.
remove_flash = ->
  $('.flash').fadeOut 1500, ->
    $('.flash').remove()
