$("#membership-plans-plan-duration-monthly").click(function(event){
    $(this).addClass('active-red');
    $("#membership-plans-plan-content-monthly").removeClass('active-display');

    $("#membership-plans-plan-duration-annual").removeClass('active-red');
    $("#membership-plans-plan-content-annual").addClass('active-display');
})
$("#membership-plans-plan-duration-annual").click(function(event){
    $(this).addClass('active-red');
    $("#membership-plans-plan-content-annual").removeClass('active-display');

    $("#membership-plans-plan-duration-monthly").removeClass('active-red');
    $("#membership-plans-plan-content-monthly").addClass('active-display');        
})