$(function(){
  $('#loginDropdown').on('click', function(event) {
      event.preventDefault(); 
      event.stopPropagation();
      $(this).parent().toggleClass('open');    
  });
})