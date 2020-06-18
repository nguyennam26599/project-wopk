$(document).on("turbolinks:load", function () {
	$(window).scroll(function () {
		if ($(this).scrollTop() > 50) {
			$('#back-to-top').fadeIn().removeClass('d-none');
		} else {
			$('#back-to-top').fadeOut();
		}
	});
	$('#back-to-top').click(function () {
		$('body,html').animate({
			scrollTop: 0
		}, 400);
		return false;
	});
});