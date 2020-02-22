$(document).ready(function(){
  (function(e,t,n){var r=e.querySelectorAll("html")[0];r.className=r.className.replace(/(^|\s)no-js(\s|$)/,"$1js$2")})(document,window,0);

  /*
	$('.main-navi > li > a').click(function(e){
		if($(this).closest("li").children("ul").length) {
			e.preventDefault();
			$(this).closest('li').find('ul').toggleClass('active');
		}
	});
  */

	$('[data-toggle="tooltip"]').tooltip();

	$("#owl-carousel").owlCarousel({
		loop: true,
		nav: true,
		dots: true,
		items: 1,
		autoplay:true,
		autoplayTimeout:5000,
		autoplayHoverPause:true
	});
	$("#owl-mainpage").owlCarousel({
		loop: true,
		nav: true,
		dots: true,
		items: 1,
		autoplay:true,
		autoplayTimeout:5000,
		autoplayHoverPause:true
	});

	$("#single-gallery").owlCarousel({
		loop: true,
		nav: true,
		dots: false,
		items: 1,
		autoplay:true,
		autoplayTimeout:5000,
		autoplayHoverPause:true,
		thumbs: true,
    	thumbsPrerendered: true
	});
	$('#-single-gallery-thumbs').owlCarousel({
		loop:true,
		margin:10,
		nav: true,
		dots: false,
		items: 7,
		responsive:{
		    0:{
		        items:3
		    },
		    768:{
		        items:5
		    },
		    992:{
		        items:7
		    }
		}
	})

  	$("#similar-items").owlCarousel({
		loop: false,
		nav: true,
		dots: false,
		items: 4,
		autoplay:false,
		responsive:{
		    0:{
		        items:1
		    },
		    768:{
		        items:3
		    },
		    992:{
		        items:4
		    }
		}
	});

  	$("#listing-ads-slider").owlCarousel({
		loop: false,
		nav: true,
		dots: false,
		items: 3,
		autoplay:false,
		responsive:{
		    0:{
		        items:1
		    },
		    768:{
		        items:2
		    },
		    992:{
		        items:3
		    }
		}
	});

  	$("#listing-ads-jobs-slider").owlCarousel({
		loop: false,
		nav: true,
		dots: false,
		items: 3,
		autoplay:false,
		responsive:{
		    0:{
		        items:1
		    },
		    768:{
		        items:2
		    },
		    992:{
		        items:3
		    }
		}
	});

  	$("#listing-ads-services-slider").owlCarousel({
		loop: false,
		nav: true,
		dots: false,
		items: 3,
		autoplay:false,
		responsive:{
		    0:{
		        items:1
		    },
		    768:{
		        items:2
		    },
		    992:{
		        items:3
		    }
		}
	});

    $("#listing-ads-content-slider").owlCarousel({
    loop: false,
    nav: true,
    dots: false,
    items: 3,
    autoplay:false,
    responsive:{
        0:{
            items:1
        },
        768:{
            items:2
        },
        992:{
            items:3
        }
    }
  });

	var click = 1;

	$(".hamburger").on("click", clickHamb);

	function clickHamb() {
	    if ( click == 1 ) {
	        $(this).addClass('is-active');
	        $('.mobile-nav').slideToggle(300);
	        click = 2;
	    } else {
			$(this).removeClass('is-active');
			$('.mobile-nav').hide();
	        click = 1;
	    }
	}
	/*
	var click2 = 1;

	$(".ico-search").on("click", clickSearch);

	function clickSearch() {
	    if ( click2 == 1 ) {
	        $('.header-search-form').css('opacity', '1');
			$(this).addClass('active');
	        click2 = 2;
	    } else {
			$('.header-search-form').css('opacity', '0');
			$(this).removeClass('active');
	        click2 = 1;
	    }
	}
	*/
		var click2 = 1;

		$("#show-mobile-searchbar").on("click", clickSearchbar);

		function clickSearchbar() {
		    if ( click2 == 1 ) {
		        $(this).addClass('active');
		        $('.mobile-search').slideToggle(300);
		        click2 = 2;
		    } else {
				$(this).removeClass('active');
				$('.mobile-search').hide();
		        click2 = 1;
		    }
		}

	/*$('.image-popup-no-margins').magnificPopup({
		type: 'image',
		closeOnContentClick: true,
		closeBtnInside: false,
		fixedContentPos: true,
		mainClass: 'mfp-no-margins mfp-with-zoom', // class to remove default margin from left and right side
		image: {
			verticalFit: true
		},
		zoom: {
			enabled: true,
			duration: 300 // don't foget to change the duration also in CSS
		}
	});*/
	document.addEventListener("turbolinks:load", function() {
		console.log("Loaded")
		$('.popup-with-zoom-anim').magnificPopup({
			type: 'inline',

			fixedContentPos: false,
			fixedBgPos: true,

			overflowY: 'auto',

			closeBtnInside: true,
			preloader: false,

			midClick: true,
			removalDelay: 300,
			mainClass: 'my-mfp-zoom-in'
		});

	})

	$('.popup-with-move-anim').magnificPopup({
		type: 'inline',

		fixedContentPos: false,
		fixedBgPos: true,

		overflowY: 'auto',

		closeBtnInside: true,
		preloader: false,

		midClick: true,
		removalDelay: 300,
		mainClass: 'my-mfp-slide-bottom'
	});

 	// Prevent # errors
	$('[href="#"]').click(function (e) {
		e.preventDefault();
	});


  //Check to see if the window is top if not then display button
	$(window).scroll(function(){
		if ($(this).scrollTop() > 300) {
			$('.backToTop').addClass('active');
		} else {
			$('.backToTop').removeClass('active');
		}
	});

	// smoth scroll
	$('a[href^="#section"]').click(function(){
        var el = $(this).attr('href');
        $('body').animate({
            scrollTop: $(el).offset().top}, 1000);
        return false;
	});

	/*$(window).scroll(function(){
		if($(window).scrollTop() > 500 ){
			$('.navigation').css('display', 'block');
		} else {
			$('.navigation').css('display', 'none');
		}
		if($(window).scrollTop() > 700 ){
			$('.floating-header').css('visibility', 'visible').fadeIn(500);
		} else {
			$('.floating-header').css('visibility', 'hidden').fadeOut(500);
		}
	});*/

	$('.fileform input').on('change', function(){
		str = $(this).val();
	    if (str.lastIndexOf('\\')){
	        var i = str.lastIndexOf('\\')+1;
	    }
	    else{
	        var i = str.lastIndexOf('/')+1;
	    }
	    var filename = str.slice(i);
	    console.log(filename);
	    var uploaded = $(this).parents('.fileform').find("#fileformlabel").html(filename);
	});

  // another fileinput that shows number of selected files
  $('.inputfile:not(.skip-auto)').MultiFile({
    max: 5,
    accept: 'jpg|png|gif|jpeg',
    list: '.inputfile-list',
    maxfile: 2048,
  });

  $('.inputfile.listing').MultiFile({
    max: $('.inputfile.listing').attr('data-max-files'),
    accept: 'jpg|png|gif|jpeg',
    list: '.inputfile-list',
    maxfile: 2048,
    afterFileAppend: function(el, val, master) {
      var n = 0;
      $(el).parents('form').find('input[name^="listing[photos_attributes]"]').each(function(i, input) {
        var match = $(input).attr('name').match(/listing\[photos_attributes\]\[(\d+)\]/);
        if(match && parseInt(match[1]) > n)
          n = parseInt(match[1]);
      });

      $(el).attr('name', 'listing[photos_attributes][' + (n + 1) + '][image]');
    }
  });

  var inputs = document.querySelectorAll( '.inputfile' );
  // Array.prototype.forEach.call( inputs, function( input )
  // {
  // 	var label	 = $(input).find('label'),
  // 		labelVal = label.innerHTML;
  //
  // 	input.addEventListener( 'change', function( e )
  // 	{
  // 		var fileName = '';
  //     var errors = 0
  //     $.each(e.target.files, function( index, value ) {
  //       var ext = value.name.split( '.' ).pop().toLowerCase();
  //       if ($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
  //         // alert('invalid extension! Only .png, .jpg and .jpeg allowed ');
  //         errors ++
  //       };
  //       // if (value.size > 2097152 || value.fileSize > 2097152){
  //       //   alert('Sorry, Maximum allowed filesize is 2Mb');
  //       //   e.stopPropagation();
  //       // }
  //     });
  //     if (errors > 0){
  //
  //     } else if (this.files && this.files.length > 5 ) {
  //       // alert('Please select less than 5 files');
  //     } else if( this.files && this.files.length > 1 ) {
  // 			fileName = ( this.getAttribute( 'data-multiple-caption' ) || '' ).replace( '{count}', this.files.length );
  //     } else{
  // 			fileName = e.target.value.split( '\\' ).pop();
  //     }
  //
  //
  //     if (errors > 0){
  //
  //     } else if( fileName ){
  // 			label.innerHTML = fileName;
  // 		} else {
  // 			label.innerHTML = labelVal;
  //     }
  //
  //     // var strToPrepend = fileName + ' ,' + "<br/>"
  //     // $(this).closest('.fileform-multiple').find('small').prepend(strToPrepend);
  //
  // 	});
  // });

  $('.fileform-multiple .selectbutton, .fileform-multiple label').on('click', function(){
    $(this).parent().find('input:last-child').click();
  });

});


	// function getName (str){
	//     if (str.lastIndexOf('\\')){
	//         var i = str.lastIndexOf('\\')+1;
	//     }
	//     else{
	//         var i = str.lastIndexOf('/')+1;
	//     }
	//     var filename = str.slice(i);
	//     var uploaded = document.getElementById("fileformlabel");
	//     uploaded.innerHTML = filename;
	// }
