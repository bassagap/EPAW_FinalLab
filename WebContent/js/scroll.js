$(function() {
                        $('a[href*=#]:not([href=#])').click(function() {
				if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
					var target = $(this.hash);
					target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
					if (target.length) {
						$('html,body').animate({
							scrollTop: target.offset().top-75
						}, 500);
						return false;
					}
				}
			});
		});

		$(document).ready(function () {
			$(window).scroll(function () {
				if ($(this).scrollTop() > 100) {
					$('.flecha').fadeIn();
				} else {
					$('.flecha').fadeOut();
				}
                                if ($(this).scrollTop() > 780) {
					$('.menu2').fadeIn();
				} else {
					$('.menu2').fadeOut();
				}
			});

			$('.flecha').click(function () {
				$("html, body").animate({
					scrollTop: 0
				}, 600);
				return false;
			});
                        $('.zonaboton').click(function () {
				$("html, body").animate({
					scrollTop: 0
				}, 600);
				return false;
			});
		});
		