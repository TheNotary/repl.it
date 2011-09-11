# Extension module.
# Responsible for Google Analytics tracking.

$ = jQuery

$.extend REPLIT,
  language_start_time: null
  InitAnalytics: ->
    window._gaq = window._gaq || []
    window._gaq.push ['_setAccount', 'UA-25629695-1']
    window._gaq.push(['_setDomainName', 'none']);
    window._gaq.push(['_setAllowLinker', true]);
    window._gaq.push(['_trackPageview']);

    ga_script = document.createElement 'script'
    ga_script.type = 'text/javascript'
    ga_script.async = true
    ga_script.src = 'http://www.google-analytics.com/ga.js'

    first_script = document.getElementsByTagName('script')[0]
    first_script.parentNode.insertBefore ga_script, first_script

$ ->
  REPLIT.InitAnalytics()

  # Set up language tracking.
  REPLIT.$this.bind 'language_loading', (_, system_name) ->
    REPLIT.language_start_time = Date.now()
    window._gaq.push ['_trackEvent', 'language_loading', system_name]
  REPLIT.$this.bind 'language_loaded', (_, system_name) ->
    # Note that the value must be a string, even though it's used as an int.
    if REPLIT.language_start_time?
      time_taken = String Date.now() - REPLIT.language_start_time
    else
      time_taken = '0'
    window._gaq.push ['_trackEvent', 'language_loaded', system_name, time_taken]

  # Set up button tracking.
  $('#button-languages').click ->
    window._gaq.push ['_trackEvent', 'button', 'languages']
  $('#button-examples').click ->
    window._gaq.push ['_trackEvent', 'button', 'examples']
  $('#button-save').click ->
    window._gaq.push ['_trackEvent', 'button', 'save']
  $('#button-help').click ->
    window._gaq.push ['_trackEvent', 'button', 'help']

  # Set up footer link tracking.
  $('#link-about').click ->
    window._gaq.push ['_trackEvent', 'link', 'about']
  $('#link-source-code').click ->
    window._gaq.push ['_trackEvent', 'link', 'source']
  $('#language-about-link').click ->
    window._gaq.push ['_trackEvent', 'link', 'language']
  $('#language-engine-link').click ->
    window._gaq.push ['_trackEvent', 'link', 'engine']