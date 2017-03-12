$ ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_posts_url = $('.pagination a[rel=next]').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
          $('.pagination').html("")
          console.log("AKII")
          console.log(more_posts_url)
          $.getScript more_posts_url
      if !more_posts_url
        $('.pagination').html("")
    return
