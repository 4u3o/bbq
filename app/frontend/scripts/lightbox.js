$(document).on('click', '[data-toggle="lightbox"]', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox({
    onShow: function () {
      $('.close').removeClass('close').addClass('btn-close')
        .attr('aria-label', 'Close')
        .children('span').remove();
    }
  });
});
