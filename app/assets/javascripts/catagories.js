$(document).ready(function() {
  $('.new-book-category').click(function(){
    $(this).text($(this).text() == "Cancel" ? " New book": "Cancel");
    $(this.nextElementSibling).toggle();
  });
});
