$(function(){
    $('form div input').focus(function(){
      $(this).parent().addClass('active');
    })
    $('form div input').blur(function(){
      const checkValue = $(this).val()
      if(checkValue.trim() == ''){
        $(this).parent().removeClass('active');
        $(this).val('');
      }
    })
})

