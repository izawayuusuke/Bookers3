document.addEventListener("turbolinks:load", ->
  getUrlVars = ->
    vars = {}
    param = location.search.substring(1).split('&')
    i = 0
    while i < param.length
      keySearch = param[i].search(RegExp('='))
      key = ''
      if `keySearch != -1`
        key = param[i].slice(0, keySearch)
      val = param[i].slice(param[i].indexOf('=', 0) + 1)
      if `key != ''`
        vars[key] = decodeURI(val)
      i++
    vars

  $ ->
    val = getUrlVars()
    submit_select = val.submit_select
    if submit_select
      now_select = $('#submit_select').find('option[value="' + submit_select + '"]')
      $(now_select).prop 'selected', true
    return

  $ ->
    $('#submit_form').change ->
      $(this).submit()
      return
    return
)
