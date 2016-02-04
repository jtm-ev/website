$(document).ready(function(){
	$('.brand.item.mobile').on("click",function(e){
        e.preventDefault();
		$('.ui.vertical.menu').toggle().transition("fade up");
	});

	//$('.ui.dropdown').dropdown();
});
