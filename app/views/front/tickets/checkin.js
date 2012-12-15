if (<%= @success %>) {
  $('.checkin-link-<%= @ticket.id %>').html('yes').parent().effect('highlight');
}