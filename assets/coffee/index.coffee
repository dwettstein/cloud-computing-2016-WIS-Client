$(document).on 'ready', () ->
  $response = $ '#response .display'

  $('ul.nav-tabs a').on 'click', ->
    page = $(this).data('id')

    # handle nav-tabs history
    window.history.pushState({}, "Where Is the Sun client - #{page.toUpperCase()}", "/#{page}")
    document.title = "Where Is the Sun client - #{page}"

    # empty $response
    $response.removeClass('error').empty()


  # handle asynchronous form
  $('form').on 'submit', () ->
    $this = $(this)
    url = $this.attr('action')

    if url == '#'
      alert 'You have to fill the "action" attribut of the form with the target url of your API'
      return false

    params = $this.find("input[type='text']").filter(-> return this.value).serialize()
    url += '?' + params if params.length

    $.getJSON url, (data) ->
      $response.removeClass('error').text JSON.stringify(data, null, 2)
    .error (err, message) ->
      console.log(err)
      $response.addClass('error').text("Error: #{message}")
      $response.append("\nStatus: #{err.status} - #{err.statusText}")
      $response.append("\nResponse: #{err.responseText}") if err.responseText && err.status != 200

    return false
