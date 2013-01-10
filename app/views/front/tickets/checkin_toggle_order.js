var statuses = <%= @statuses.to_json.html_safe %>;
console.log(statuses);

$.each(statuses, function(ticket_id, status) {
  if (status) {
    $('.checkin-link-' + ticket_id).find('a').addClass('btn-warning').parent().effect('highlight');
  } else {
    $('.checkin-link-' + ticket_id).find('a').removeClass('btn-warning').parent().effect('highlight');
  }
});