var url_fragments = function() {
  var href_info = document.location.href.split('#access_token=');
  var stripped_url = href_info[1].split('&');
  $.getJSON('/api/fitbit', {codes: stripped_url});
}
