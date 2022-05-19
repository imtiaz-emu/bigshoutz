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

  $('.products-number a').click(function () {
    var queries = queryParameters();
    queries['num'] = $(this).data('value');

    document.location.href = "?" + $.param(queries);
  });

  $('.products-sort-by').on('change', function () {
    var queries = queryParameters();
    queries['sort_by'] = $(this).find(":selected").val();

    document.location.href = "?" + $.param(queries);
  });

  changeSelectedProductNumber();

  function queryParameters(){
    var queries = {};

    $.each(document.location.search.substr(1).split('&'), function(c,q){
      var i = q.split('=');
      queries[i[0].toString()] = unescape(i[1].toString());
    });

    return queries;
  }

  function changeSelectedProductNumber() {
    var queryDict = {};
    location.search.substr(1).split("&").forEach(function(item) {queryDict[item.split("=")[0]] = item.split("=")[1]})

    $('.products-number a').each(function(){
      if(queryDict['num'] == undefined && $(this).data('value') == '12'){
        $(this).addClass('btn-primary');
        $(this).removeClass('btn-outline-secondary');
      }
      else if(queryDict['num'] == $(this).data('value')){
        $(this).addClass('btn-primary');
        $(this).removeClass('btn-outline-secondary');
      }else{
        $(this).removeClass('btn-primary');
        $(this).addClass('btn-outline-secondary');
      }
    });
  }
});
