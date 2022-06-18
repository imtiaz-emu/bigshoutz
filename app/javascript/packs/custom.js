$(document).on('turbolinks:load', function() {
  $('.shop-detail-carousel').owlCarousel({
    items: 1,
    thumbs: true,
    nav: false,
    dots: false,
    loop: true,
    autoplay: true,
    thumbsPrerendered: true
  });

  $('#free-listing').click(function () {
    if($(this).prop("checked") == true){
      init_price_fields(true, 'price', '0.0');
      init_price_fields(true, 'currency', 'MYR');
    }
    else {
      init_price_fields(false, 'price', '0.0');
      init_price_fields(false, 'currency', '');
    }
  });

  function init_price_fields(disable, property, value){
    $(`input[name="listing[${property}]"]`).attr('disabled', disable);
    $(`input[name="listing[${property}]"]`).val(value);
  }

  $('#comment-cancel').click(function () {
    $('textarea[name="comment[description]"]').val('');
  });

  $('[data-toggle="tooltip"]').tooltip()
});
