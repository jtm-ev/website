$(document).ready(function(){
	$('.brand.item.mobile').on("click",function(e){
        e.preventDefault();
		$('#nav_menu_dropdown').toggle().transition("fade up");
	});

	$('#action_toggle').on("click",function(e){
        e.preventDefault();
		$('#action_dropdown').toggle().transition("fade down");
	});

	$('#create_toggle').on("click",function(e){
        e.preventDefault();
		$('#create_dropdown').toggle().transition("fade down");
	});
});
