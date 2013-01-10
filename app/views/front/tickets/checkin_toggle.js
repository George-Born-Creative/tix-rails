if (<%= @checked_in %>) {
  $('.checkin-link-<%= @ticket.id %>').find('a').addClass('btn-warning').parent().effect('highlight');
} else {
  $('.checkin-link-<%= @ticket.id %>').find('a').removeClass('btn-warning').parent().effect('highlight');
}