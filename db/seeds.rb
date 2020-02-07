# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do

	cat3 = Category.create(id: 3, name: 'Stuff for sale')
	cat4 = Category.create(id: 4, name: 'Services')
	cat5 = Category.create(id: 5, name: 'Jobs')
	cat6 = Category.create(id: 6, name: 'Motors')
	cat7 = Category.create(id: 7, name: 'Properties')
	cat8 = Category.create(id: 8, name: 'Pets')
	cat9 = Category.create(id: 9, name: 'Neighbourhood')

	%w(Asia Africa Europe N.America S.America Oceania).each do |cont_name|
		Continent.create(name: cont_name)
	end
	u1 = User.create(id: 1, email: "xs290@me.com", first_name: "Sergey", last_name: "Khmelevskoy", password: "password", password_confirmation: "password", language: "English", created_at: "2016-10-02 22:04:15", updated_at: "2016-10-02 22:04:15", nomoderation: true, confirmed_at: Time.now)

	sub1 = Subcategory.create(category_id: 5, name: "Accountancy")
	sub2 = Subcategory.create(category_id: 5, name: "Administration")
	sub3 = Subcategory.create(category_id: 5, name: "Apprenticeships")
	sub4 = Subcategory.create(category_id: 5, name: "Abroad")
	sub5 = Subcategory.create(category_id: 5, name: "Child minding")
	sub6 = Subcategory.create(category_id: 5, name: "Banking")
	sub7 = Subcategory.create(category_id: 5, name: "Charity work")
	sub8 = Subcategory.create(category_id: 5, name: "Computing & IT")
	sub9 = Subcategory.create(category_id: 5, name: "Construction/Estates")
	sub10 = Subcategory.create(category_id: 5, name: "Data Entry")

	sub11 = Subcategory.create(category_id: 6, name: "Cars")
	sub12 = Subcategory.create(category_id: 6, name: "Vans")
	sub13 = Subcategory.create(category_id: 6, name: "Trucks")
	sub14 = Subcategory.create(category_id: 6, name: "Motorbikes")
	sub15 = Subcategory.create(category_id: 6, name: "Scooters")
	sub16 = Subcategory.create(category_id: 6, name: "Tractors & Plants")
	sub17 = Subcategory.create(category_id: 6, name: "Campervans")
	sub18 = Subcategory.create(category_id: 6, name: "Motorhomes")
	sub19 = Subcategory.create(category_id: 6, name: "Caravans")
	sub20 = Subcategory.create(category_id: 6, name: "Parts")

	sub21 = Subcategory.create(category_id: 9, name: "Theatres")
	sub22 = Subcategory.create(category_id: 9, name: "Artists")
	sub23 = Subcategory.create(category_id: 9, name: "Events & Shows")
	sub24 = Subcategory.create(category_id: 9, name: "Classes & Clubs")
	sub25 = Subcategory.create(category_id: 9, name: "Music & Musicians")
	sub26 = Subcategory.create(category_id: 9, name: "Associations")
	sub27 = Subcategory.create(category_id: 9, name: "Sports")
	sub28 = Subcategory.create(category_id: 9, name: "Travel")
	sub29 = Subcategory.create(category_id: 9, name: "Nightlife")
	sub30 = Subcategory.create(category_id: 9, name: "Other")

	sub31 = Subcategory.create(category_id: 8, name: "pets for sale")
	sub32 = Subcategory.create(category_id: 8, name: "equipment")
	sub33 = Subcategory.create(category_id: 8, name: "pets grooming ")
	sub34 = Subcategory.create(category_id: 8, name: "accessories")
	sub35 = Subcategory.create(category_id: 8, name: "missing & lost")
	sub36 = Subcategory.create(category_id: 8, name: "found")
	sub37 = Subcategory.create(category_id: 8, name: "vets")
	sub38 = Subcategory.create(category_id: 8, name: "pets hotels")
	sub39 = Subcategory.create(category_id: 8, name: "others")

	sub41 = Subcategory.create(category_id: 7, name: "For sale")
	sub42 = Subcategory.create(category_id: 7, name: "House")
	sub43 = Subcategory.create(category_id: 7, name: "Flat")
	sub44 = Subcategory.create(category_id: 7, name: "Commercial")
	sub45 = Subcategory.create(category_id: 7, name: "Industrial")
	sub46 = Subcategory.create(category_id: 7, name: "Offices")
	sub47 = Subcategory.create(category_id: 7, name: "Land")
	sub48 = Subcategory.create(category_id: 7, name: "Other")
	sub49 = Subcategory.create(category_id: 7, name: "Rent")

	sub51 = Subcategory.create(category_id: 4, name: "Business")
	sub52 = Subcategory.create(category_id: 4, name: "Office")
	sub53 = Subcategory.create(category_id: 4, name: "Advertising")
	sub54 = Subcategory.create(category_id: 4, name: "Accountancy")
	sub55 = Subcategory.create(category_id: 4, name: "Wholesale")
	sub56 = Subcategory.create(category_id: 4, name: "Childcare & Childminding")
	sub57 = Subcategory.create(category_id: 4, name: "Clothing")
	sub58 = Subcategory.create(category_id: 4, name: "Dry cleaning")
	sub59 = Subcategory.create(category_id: 4, name: "Computers& Telecoms")
	sub60 = Subcategory.create(category_id: 4, name: "Software")



	l1 = Listing.create(name: "Apple Inc", brand: "Apple", condition: "New",
						location: "London, United Kindgdom", description: "Lorem Ipsum on yksinkertaisesti testausteksti, jota tulostus- ja ladontateollisuudet käyttävät. Lorem Ipsum on ollut teollisuuden normaali testausteksti jo 1500-luvulta asti, jolloin tuntematon tulostaja otti kaljuunan ja sekoitti sen tehdäkseen esimerkkikirjan. Se ei ole selvinnyt vain viittä vuosisataa, mutta myös loikan elektroniseen kirjoitukseen, jääden suurinpiirtein muuntamattomana. Se tuli kuuluisuuteen 1960-luvulla kun Letraset-paperiarkit, joissa oli Lorem Ipsum pätkiä, julkaistiin ja vielä myöhemmin tietokoneen julkistusohjelmissa, kuten Aldus PageMaker joissa oli versioita Lorem Ipsumista.",
						delivery_time: "200", delivery_cost: "339", price: "2322", user_id: 1, category_id: 1,
						subcategory_id: nil, created_at: "2016-10-02 19:59:26", updated_at: "2016-10-02 19:59:26",
						latitude: 51.5073509, longitude: -0.1277583)

	l2 = Listing.create(name: "Apple Inc", brand: "Apple", condition: "New",
						location: "London, United Kindgdom", description: "Lorem Ipsum on yksinkertaisesti testausteksti, jota tulostus- ja ladontateollisuudet käyttävät. Lorem Ipsum on ollut teollisuuden normaali testausteksti jo 1500-luvulta asti, jolloin tuntematon tulostaja otti kaljuunan ja sekoitti sen tehdäkseen esimerkkikirjan. Se ei ole selvinnyt vain viittä vuosisataa, mutta myös loikan elektroniseen kirjoitukseen, jääden suurinpiirtein muuntamattomana. Se tuli kuuluisuuteen 1960-luvulla kun Letraset-paperiarkit, joissa oli Lorem Ipsum pätkiä, julkaistiin ja vielä myöhemmin tietokoneen julkistusohjelmissa, kuten Aldus PageMaker joissa oli versioita Lorem Ipsumista.",
						delivery_time: "200", delivery_cost: "339", price: "2322", user_id: 1, category_id: 4,
						subcategory_id: nil, created_at: "2016-10-02 19:59:26", updated_at: "2016-10-02 19:59:26",
						latitude: 51.5073509, longitude: -0.1277583)


	AdminUser.create!(email: 'admin@mail.com', password: 'admin123', password_confirmation: 'admin123')

	Banner.create!(
		banner_top: '<p><a href="#"><img alt="" class="img-responsive center-block" src="http:/placehold.it/468x81" /> </a> <!-- LIKE THIS --> <!-- <a href="#"><img src="/images/banner-top.png" alt="" class="img-responsive center-block"></a> --></p>',
		banner_left_sidebar: '<p><a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/250x250" /></a> <a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/250x125" /></a> <!-- <a href="#"><img src="/images/ad-left-sidebar-250.png" alt="" class="img-responsive"></a> <a href="#"><img src="/images/ad-sidebar-left-125.png" alt="" class="img-responsive"></a> --></p>',
		banner_right_sidebar_long: '<p><a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/250x220" /></a> <a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/250x96" /></a> <a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/250x400" /></a> <a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/250x90" /></a> <!--<a href="#"><img src="/images/ad-right-sidebar-202.png" alt="" class="img-responsive"></a> <a href="#"><img src="/images/ad-right-sidebar-96.png" alt="" class="img-responsive"></a> <a href="#"><img src="/images/ad-right-sidebar-400.png" alt="" class="img-responsive"></a> <a href="#"><img src="/images/ad-right-sidebar-90.png" alt="" class="img-responsive"></a>--></p>',
		banner_right_sidebar_short: '<p><a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/250x220" /></a> <a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/250x96" /></a> <!--<a href="#"><img src="/images/ad-right-sidebar-202.png" alt="" class="img-responsive"></a> <a href="#"><img src="/images/ad-right-sidebar-96.png" alt="" class="img-responsive"></a>--></p>',
		banner_bottom: '<p><a href="#"><img alt="" class="img-responsive" src="http:/placehold.it/468x81" /></a> <!--<a href="#"><img src="/images/ad-banner-468.png" alt="" class="img-responive" /></a>--></p>',
		banner_header_top: '<p><a class="header-banner-top" href="#"><img alt="Banner" class="img-responsive" src="http://placehold.it/481x60" /> </a> <!-- STANDART BANNER --> <!--<img src="/images/banner-header.png" class="img-responsive" alt="Banner">--></p>'
	)

	podcast_cover  = File.open(File.join(Rails.root,"test/images/podcast_header_image.png"))

	Template.create!([
		{facebook_link: "https://trello.com/c/1uJyDr1B/97-contact-form", twitter_link: "https://twitter.com", googleplus_link: "https://googleplus.com", youtube_link: "https://youtube.com", mainpage_slider: "<div class=\"mainpage-slider-slide\" style=\"background-image: url('/images/slider1.jpg')\"></div>\r\n<div class=\"mainpage-slider-slide\" style=\"background-image: url('/images/slider1.jpg')\"></div>\r\n<div class=\"mainpage-slider-slide\" style=\"background-image: url('/images/slider1.jpg')\"></div>", about_slider: "<div class=\"mainpage-slider-slide\" style=\"background-image: url(\"images/slider1.jpg\")\"> <div class=\"mainpage-slider-slide-title\">About us</div> </div> <div class=\"mainpage-slider-slide\" style=\"background-image: url(\"images/slider1.jpg\")\"></div> <div class=\"mainpage-slider-slide\" style=\"background-image: url(\"images/slider1.jpg\")\"></div>", about_text: "<div class=\"row\"> <div class=\"col-sm-8\"> <h1>What makes us different</h1> <p>This is Photoshops version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio tincidunt auctor a ornare odio. Sed non mauris vitae erat consequat auctor eu in elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris in erat justo. Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi. Proin condimentum fermentum nunc. Etiam pharetra, erat sed fermentum feugiat, velit mauris egestas quam, ut aliquam massa nisl quis neque. Suspendisse in orci enim.</p> <p>Sed non mauris vitae erat consequat auctor eu in elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris in erat justo. Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi. Proin condimentum fermentum nunc. Etiam pharetra, erat sed fermentum feugiat, velit mauris egestas quam, ut aliquam massa nisl quis neque. Suspendisse in orci enim.</p> <h1>About this website</h1> <p>This is Photoshops version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio tincidunt auctor a ornare odio. Sed non mauris vitae erat consequat auctor eu in elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris in erat justo. Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi. Proin condimentum fermentum nunc. Etiam pharetra, erat sed fermentum feugiat, velit mauris egestas quam, ut aliquam massa nisl quis neque. Suspendisse in orci enim.</p> <p>This is Photoshops version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio tincidunt auctor a ornare odio. Sed non mauris vitae erat consequat auctor eu in elit. </p> </div> <div class=\"col-sm-4\"> <h1>Our story</h1> <p>This is Photoshops version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio tincidunt auctor a ornare odio. Sed non mauris vitae erat consequat auctor eu in elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris in erat justo. Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi. Proin condimentum fermentum nunc. Etiam pharetra, erat sed fermentum feugiat, velit mauris egestas quam, ut aliquam massa nisl quis neque. Suspendisse in orci enim..</p> </div> </div> <div class=\"row\"> <div class=\"col-sm-7 col-sm-offset-5\"> <h1>About this website</h1> </Div> <div class=\"col-sm-5\"> <img src=\"images/text-page-simple.png\" alt=\"\" class=\"img-responsive\" /> </div> <div class=\"col-sm-7\"> <p>This is Photoshops version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio tincidunt auctor a ornare odio. Sed non mauris vitae erat consequat auctor eu in elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris in erat justo. Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi. Proin condimentum fermentum nunc. Etiam pharetra, erat sed fermentum feugiat, velit mauris egestas quam, ut aliquam massa nisl quis neque. Suspendisse in orci enim.</p> <p>This is Photoshops version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio tincidunt auctor a ornare odio. Sed non mauris vitae erat consequat auctor eu in elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris in erat justo. Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi. Proin condimentum fermentum nunc. Etiam pharetra, erat sed fermentum feugiat, velit mauris egestas quam, ut aliquam massa nisl quis neque. mate.</p> </div> </div>", contact_details: "<div class=\"row contact-row text-center\"> <div class=\"col-xs-3\"><i class=\"ico ico-location2\"></i></div> <div class=\"col-xs-9\"> 20 ORCHARD GARDENS,SUTTON, SM1 2QD<br> United Kingdom, London </div> </div> <div class=\"row contact-row text-center\"> <div class=\"col-xs-3\"><i class=\"ico ico-phone2\"></i></div> <div class=\"col-xs-9\"> Tel: 01303 680311 </div> </div> <div class=\"row contact-row text-center\"> <div class=\"col-xs-3\"><i class=\"ico ico-mobile2\"></i></div> <div class=\"col-xs-9\"> Mob: 07889 635427 </div> </div> <div class=\"row contact-row text-center\"> <div class=\"col-xs-3\"><i class=\"ico ico-email\"></i></div> <div class=\"col-xs-9\"> <a href=\"mailto:info@yourdomain.com\">info@yourdomain.com</a> </div> </div>", feedback_slider: "\t\t\t\t\t\t<div class=\"mainpage-slider-slide\" style=\"background-image: url(\"/images/slider1.jpg\")\">\r\n\t\t\t\t\t\t\t<div class=\"mainpage-slider-slide-title\">Feedbacks</div>\r\n\t\t\t\t\t\t\t<a href=\"#leave-feedback-popup\" class=\"popup-with-zoom-anim btn-pink have-fill mainpage-slider-slide-btn\">leave your feedback</a>\r\n\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t<div class=\"mainpage-slider-slide\" style=\"background-image: url(\"/images/slider1.jpg\")\">\r\n\t\t\t\t\t\t\t<div class=\"mainpage-slider-slide-title\">Feedbacks</div>\r\n\t\t\t\t\t\t\t<a href=\"#leave-feedback-popup\" class=\"popup-with-zoom-anim btn-pink have-fill mainpage-slider-slide-btn\">leave your feedback</a>\r\n\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t<div class=\"mainpage-slider-slide\" style=\"background-image: url(\"/images/slider1.jpg\")\">\r\n\t\t\t\t\t\t\t<div class=\"mainpage-slider-slide-title\">Feedbacks</div>\r\n\t\t\t\t\t\t\t<a href=\"#leave-feedback-popup\" class=\"popup-with-zoom-anim btn-pink have-fill mainpage-slider-slide-btn\">leave your feedback</a>\r\n\t\t\t\t\t\t</div>", feedback_text: "\t\t\t\t\t\t\t\t<h1>Short text slogan</h1>\r\n\t\t\t\t\t\t\t\t<p>This is Photoshops version  of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit. Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio tincidunt auctor a ornare odio. Sed non  mauris vitae erat consequat auctor eu in elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris in erat justo. Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi. Proin condimentum fermentum nunc. Etiam pharetra, erat sed fermentum feugiat, velit mauris egestas quam, ut aliquam massa nisl quis neque. Suspendisse in orci enim.</p>", support_slider: "<div class=\"mainpage-slider-slide\" style=\"background-image: url(\"images/slider-support.png\")\"> </div> <div class=\"mainpage-slider-slide\" style=\"background-image: url(\"images/slider-support.png\")\"></div> <div class=\"mainpage-slider-slide\" style=\"background-image: url(\"images/slider-support.png\")\"></div>", footer_text: "ok text is now editable through admin", safety_text: "Globsucceed is here to help!", mainpage_benefits: "\t\t\t\t\t\t\t\t<div class=\"benefits-title text-center\"><span>WHY BUYERS AND FREELANCERS</span><br>SHOULD CHOOSE OUR WEBSITE</div>\r\n\t\t\t\t\t\t\t\t<ul class=\"benefits-list\">\r\n\t\t\t\t\t\t\t\t\t<li><span>No commission, marketing and membership fees are required. An extra payment can occur only at your own will. </span></li>\r\n\t\t\t\t\t\t\t\t\t<li><span>Our community has taken great care in assessing and selecting the best professional freelancers from all around the globe.</span></li>\r\n\t\t\t\t\t\t\t\t\t<li><span>Both the buyer’s and the freelancer’s access of each other’s profiles, backgrounds and reviews is easily accessible. </span></li>\r\n\t\t\t\t\t\t\t\t\t<li><span>Our contact support team is working 24/7 for any open disputes and complaints. Remember, we are there for YOUR protection. </span></li>\r\n\t\t\t\t\t\t\t\t\t<li><span>No commission, marketing and membership fees are required. An extra payment can occur only at your own will. </span></li>\r\n\t\t\t\t\t\t\t\t\t<li><span>Further to our appreciation to you as a customer and a seller, we have created the Unique Project Work Space where both parties can work and communicate in a safe environment. </span></li>\r\n\t\t\t\t\t\t\t\t\t<li><span>We provide safe and instant transfer of money to any country in the world, available in your own currency.</span></li>\r\n\t\t\t\t\t\t\t\t</ul>\r\n\t\t\t\t\t\t\t\t<div class=\"text-center\">\r\n\t\t\t\t\t\t\t\t\t<a href=\"#signup-popup\" class=\"popup-with-zoom-anim btn-cta--green\">JOIN US TODAY. IT'S FREE</a>\r\n\t\t\t\t\t\t\t\t</div>", mainpage_options: "\t\t\t\t\t\t<div class=\"benefits-ico-title text-center\">Let’s work together to Succeed</div>\r\n\t\t\t\t\t\t<div class=\"row\">\r\n\t\t\t\t\t\t\t<div class=\"col-sm-4 text-center\">\r\n\t\t\t\t\t\t\t\t<i class=\"ico ico-benefit-1\"></i>\r\n\t\t\t\t\t\t\t\t<span class=\"ico-benefit-heading\">Outsource your workload </span>\r\n\t\t\t\t\t\t\t\t<span class=\"ico-benefit-description\">No upfront payments will occur until complete satisfaction is met between you and the Seller.</span>\r\n\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t<div class=\"col-sm-4 text-center\">\r\n\t\t\t\t\t\t\t\t<i class=\"ico ico-benefit-2\"></i>\r\n\t\t\t\t\t\t\t\t<span class=\"ico-benefit-heading\">Sell your services </span>\r\n\t\t\t\t\t\t\t\t<span class=\"ico-benefit-description\">Use your expertise and experience to help others. Post your service and start selling. It’s free, simple and quick.</span>\r\n\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t\t<div class=\"col-sm-4 text-center\">\r\n\t\t\t\t\t\t\t\t<i class=\"ico ico-benefit-3\"></i>\r\n\t\t\t\t\t\t\t\t<span class=\"ico-benefit-heading\">Safe community  </span>\r\n\t\t\t\t\t\t\t\t<span class=\"ico-benefit-description\">Your protection is our priority No #1 including secure payments. We are here for you 24/7</span>\r\n\t\t\t\t\t\t\t</div>\r\n\t\t\t\t\t\t</div>", mainpage_featured_in: "\t\t\t\t\t\t\t<li><a href=\"#\"><img src=\"img/bbc.png\" alt=\"\"></a></li>\r\n\t\t\t\t\t\t\t<li><a href=\"#\"><img src=\"img/cnn.png\" alt=\"\"></a></li>\r\n\t\t\t\t\t\t\t<li><a href=\"#\"><img src=\"img/dailymail.png\" alt=\"\"></a></li>\r\n\t\t\t\t\t\t\t<li><a href=\"#\"><img src=\"img/telegraph.png\" alt=\"\"></a></li>\r\n\t\t\t\t\t\t\t<li><a href=\"#\"><img src=\"img/guardian.png\" alt=\"\"></a></li>", global_footer: "\t<!-- FOOTER: START -->\r\n\t<footer>\r\n\t\t<div class=\"container\">\r\n\t\t\t<div class=\"row\">\r\n\t\t\t\t<div class=\"col-sm-2\">\r\n\t\t\t\t\t<span class=\"footer-col\">Globsucceed</span>\r\n\t\t\t\t\t<%= link_to \"About us\", about_path %>\r\n\t\t\t\t\t<%= link_to \"Contact\", contact_path %>\r\n\t\t\t\t\t<%= link_to \"Support\", support_topic_path(1) %>\r\n\t\t\t\t\t<%= link_to \"Feedbacks\", feedbacks_path %>\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class=\"col-sm-2\">\r\n\t\t\t\t\t<span class=\"footer-col\">Categories</span>\r\n\t\t\t\t\t<% @all_cats = Category.all %>\r\n\t\t\t\t\t<% @all_cats.each do |c| %>\r\n\t\t\t\t\t\t<%= link_to c.name, category_path(c.id) %>\r\n\t\t\t\t\t<% end %>\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class=\"col-sm-2\">\r\n\t\t\t\t\t<!--<span class=\"footer-col\">LINK COLOUMN 1</span>\r\n\t\t\t\t\t<a href=\"#\">ABOUT US</a>\r\n\t\t\t\t\t<a href=\"#\">OUR BLOG</a>\r\n\t\t\t\t\t<a href=\"#\">ABOUT US</a>\r\n\t\t\t\t\t<a href=\"#\">OUR BLOG</a>-->\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class=\"col-sm-3 socials\">\r\n\t\t\t\t\t<span class=\"footer-col\">Follow us</span>\r\n\t\t\t\t\t<% if $template.facebook_link.present? %>\r\n\t\t\t\t\t<a href=\"<%= \"\#{$template.facebook_link.html_safe}\" %>\" target=\"_blank\"><i class=\"ico ico-fb\"></i></a>\r\n\t\t\t\t\t<% end %>\r\n\t\t\t\t\t<% if $template.twitter_link.present? %>\r\n\t\t\t\t\t<a href=\"<%= \"\#{$template.twitter_link.html_safe}\" %>\" target=\"_blank\"><i class=\"ico ico-tw\"></i></a>\r\n\t\t\t\t\t<% end %>\r\n\t\t\t\t\t<% if $template.googleplus_link.present? %>\r\n\t\t\t\t\t<a href=\"<%= \"\#{$template.googleplus_link.html_safe}\" %>\" target=\"_blank\"><i class=\"ico ico-gplus\"></i></a>\r\n\t\t\t\t\t<% end %>\r\n\t\t\t\t\t<% if $template.youtube_link.present? %>\r\n\t\t\t\t\t<a href=\"<%= \"\#{$template.youtube_link.html_safe}\" %>\" target=\"_blank\"><i class=\"ico ico-youtube\"></i></a>\r\n\t\t\t\t\t<% end %>\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class=\"col-sm-3\">\r\n\t\t\t\t\t<a href=\"/\"><img src=\"/img/logo-footer.png\" class=\"img-responsive\" alt=\"#\"></a>\r\n\t\t\t\t\t<span class=\"footer-desc\"><%= \"\#{$template.footer_text.html_safe}\" %></span>\r\n\t\t\t\t</div>\r\n\t\t\t</div>\r\n\t\t</div>\r\n\t</footer>\r\n\t<section class=\"under-footer\">\r\n\t\t<div class=\"container\">\r\n\t\t\t<div class=\"row\">\r\n\t\t\t\t<div class=\"col-sm-6\">\r\n\t\t\t\t\t<span class=\"footer-copywrite\">© Globsucceed.com LTD 2016. All Rights Reserved</span>\r\n\t\t\t\t</div>\r\n\t\t\t\t<div class=\"col-sm-6 text-right underfooter-navi\">\r\n\t\t\t\t\t<%= link_to \"Terms & Conditions\", terms_path %>\r\n\t\t\t\t\t<%= link_to \"Privacy policy\", privacy_path %>\r\n\t\t\t\t</div>\r\n\t\t\t</div>\r\n\t\t</div>\r\n\t</section>\r\n\t<!-- FOOTER: END -->"
		podcast_header_image: podcast_cover,
		podcast_header_text: 'Lorem ipsum dolor sit consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat'
		}
	])

	scat1 = SupportTopic.create(name: 'Getting Started', content: 'Lorem Ipsum')

	scat2 = SupportTopic.create(name: 'Account', content: 'Account content lalalalal')

	scat3 = SupportTopic.create(name: 'Profile', content: 'How to setup your profile ..')

	SupportArticle.create(name: 'Some article', content: 'conten content', support_topic_id: 1)

	SupportArticle.create(name: 'Signing Up', content: 'conten content', support_topic_id: 2)
	SupportArticle.create(name: 'Security & Password', content: 'conten content', support_topic_id: 2)
	SupportArticle.create(name: 'Notifacation', content: 'conten content', support_topic_id: 2)
	SupportArticle.create(name: 'Languages', content: 'conten content', support_topic_id: 2)
	SupportArticle.create(name: 'Additional Features', content: 'conten content', support_topic_id: 2)
end