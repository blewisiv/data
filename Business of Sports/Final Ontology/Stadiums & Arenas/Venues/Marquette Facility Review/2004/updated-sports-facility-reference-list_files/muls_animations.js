// JavaScript Document
$(document).ready(function(){
	// Makes the copy under the graphic the same width as the image...
	var maingraphicwidth = $("#center #squeeze .main_content .main_graphic .shadow_left .shadow_right img").attr("width");
	$("#center #squeeze .main_content .main_graphic p").css({"width":maingraphicwidth});
	// BEGIN Edit course detail button copy
	$("#edit_cur_img .qq-uploader .qq-upload-button").text("new text");
	// END Edit course detail button copy
	// DEATH TO IE7
	$("table tbody").children("tr:nth-child(2n)").addClass("odd_row");
	// BEGIN THIS IS FOR THE SEARCH BUTTON ON THE EVENTS LISTING PAGE
	$("#block-block-13 .content #event_search #title").focus(function() {
		if (this.value == 'Search all events') {
			this.value = '';
			}
	});
	$("#block-block-13 .content #event_search #title").blur(function(){	
		if (this.value == '') {
			this.value = 'Search all events';
			}
	});
	// END EVENT LISTING SEARCH BUTTON
	// BEGIN: STUDENT & FACULTY DIRECTORY
	$("#block-block-21 #fds_search #search_fdl, #block-block-20 #fds_search #search_fdl").focus(function() {
		if (this.value == 'search by first or last name') {
			this.value = '';
			}
	});
	$("#block-block-21 #fds_search #search_fdl, #block-block-20 #fds_search #search_fdl").blur(function(){	
		if (this.value == '') {
			this.value = 'search by first or last name';
			}
	});
	// END: STUDENT & FACULTY DIRECTORY
	//BEGIN search results in event listing
	if (!$(".view-calendar .view-filters form div .views-exposed-form #edit-title").val()){
		$(".view-calendar .view-filters form div .views-exposed-form #edit-title").val("title")
	}
	if (!$(".view-calendar .view-filters form div .views-exposed-form #edit-content").val()){
		$(".view-calendar .view-filters form div .views-exposed-form #edit-content").val("content");
	}
	if (!$(".view-calendar .view-filters form div .views-exposed-form #edit-category").val()){
		$(".view-calendar .view-filters form div .views-exposed-form #edit-category").val("category");
	}
	$(".view-calendar .view-filters form div .views-exposed-form #edit-title").focus(function() {
		if (this.value == 'title') {
			this.value = '';
			}
	});
	$(".view-calendar .view-filters form div .views-exposed-form #edit-title").blur(function(){	
		if (this.value == '') {
			this.value = 'title';
			}
	});
	$(".view-calendar .view-filters form div .views-exposed-form #edit-content").focus(function() {
		if (this.value == 'content') {
			this.value = '';
			}
	});
	$(".view-calendar .view-filters form div .views-exposed-form #edit-content").blur(function(){	
		if (this.value == '') {
			this.value = 'content';
			}
	});

	$(".view-calendar .view-filters form div .views-exposed-form #edit-category").focus(function() {
		if (this.value == 'category') {
			this.value = '';
			}
	});
	$(".view-calendar .view-filters form div .views-exposed-form #edit-category").blur(function(){	
		if (this.value == '') {
			this.value = 'category';
			}
	});
	//END search results in event listing
	// BEGIN SIDEBAR MENU Animation
	$('#sidebar-left .clear-block .content > .menu > .closed_menu > a').click(function() {
		if ($(this).siblings(".menu").is(":hidden")) {
			$("#sidebar-left .clear-block .content .menu .change_arrow .menu").slideToggle('fast', function() {
			// Toggle any menu with the class 'change_arrow' added 
			});
			$("#sidebar-left .clear-block .content .menu li").removeClass("change_arrow"); // Remove the class 'change_arrow' from all menus
			$('#sidebar-left .clear-block .content > .menu > li:not(.active-trail)').addClass("closed_menu"); // Add the class 'closed_menu' from all menus
			$(this).parent().addClass("change_arrow"); // Add the class 'change_arrow' to this menu
			$(this).parent().removeClass("closed_menu"); // Temove the class 'closed_menu' to this menu
			$(this).siblings(".menu").slideToggle('fast', function() {
			// Open this menu
			});
		} else {
			$(this).parent().removeClass("change_arrow"); // Add the class 'change_arrow' to this menu
			$(this).parent().addClass("closed_menu"); // Temove the class 'closed_menu' to this menu
			$(this).siblings(".menu").slideToggle('fast', function() {
			// Open this menu
			});
		}
	});
	$('#sidebar-left .clear-block .content > .menu > .change_arrow > a').click(function() {
		$(this).parent().removeClass("change_arrow"); // Add the class 'change_arrow' to this menu
		 $(this).parent().addClass("closed_menu"); // Remove the class 'closed_menu' to this menu
		$(this).siblings(".menu").slideToggle('fast', function() {
		// Close this menu
		});
	});
	// END SIDEBAR MENU animation
	// BEGIN NEWS ARCHIVE PAGES, KEEP THE FAUX MENU OPEN
	var pathname = window.location.pathname;
	var short_pathname = pathname.substring(0, 12);
	if (short_pathname == "/newsarchive"){
		$(".menu-822-b").siblings(".menu").css({"display":"block"});
	}
	// END NEWS ARCHIVE PAGES
	// BEGIN: STYLE PAGES AROUND WUFOO FORMS
	if ($("#wrapper #container #center #squeeze .is_node_not_edit .main_content iframe")){
		var currentId = $("#wrapper #container #center #squeeze .is_node_not_edit .main_content iframe").attr('id');
		if (typeof currentId != 'undefined' && currentId.substring(0,9) == "wufooForm"){
			$("#wrapper #container #center #squeeze .is_node_not_edit .main_content iframe").parent().parent().children("h2").css({"display":"none"});
		}
	}
	// END: STYLE PAGES AROUND WUFOO FORMS
});
$(window).load(function(){
	// SAFARI AND CHROME don't play well with Drupal.behaviors
});
Drupal.behaviors.flyout_animation = function(context) {
	// BEGIN CREATE A CURRENT STATE IN THE PRIMARY NAV 
	$(".termID1 #block-menu-primary-links .content .menu li .menu-136, .termID2 #block-menu-primary-links .content .menu li .menu-137, .termID3 #block-menu-primary-links .content .menu li .menu-138, .termID4 #block-menu-primary-links .content .menu li .menu-139, .termID5 #block-menu-primary-links .content .menu li .menu-140").parent().addClass("tax_current");
	// END CREATE A CURRENT STATE IN THE PRIMARY NAV 
	// BEGIN: on the eventlisting page, when there is no watch now button, vertically center the EVENT DETAIL button
	$(".view-id-calendar .view-content .item-list ul li .views-field-view-node").css({"top": "8px"});
	$(".view-id-calendar .view-content .item-list ul li .views-field-view-node-1").css({"top":"29px"});
	$(".view-id-calendar .view-content .item-list ul li .views-field-view-node-1 .field-content a").parent().parent().siblings(".views-field-view-node").css({"top": "0px"});
	$(".view-id-calendar .view-content .item-list ul li .views-field-view-node-1 .field-content a").parent().parent().css({"top": "21px"});
	// END: on the eventlisting page, when there is no watch now button, vertically center the EVENT DETAIL button
	// BEGIN HEADER NAV ANIMATION
	$("#header-region #block-menu-primary-links > .content > .menu > li > menu").hide(function(){
		$(this).css({"left":"0px"});
	});
	$("#header-region #block-menu-primary-links > .content > .menu > li").bind('mouseenter', function() {
		if ($(this).siblings("li").hasClass("open_menu") == true){
			// if another menu is open, fade out open menu
			//the once loved alpha has been removed when going from button to button, but I only commented it out because I don't believe we won;t adjust the again...
			/* PREVIOUS ANIMATION
			$("#header-region #block-menu-primary-links > .content > .menu > .open_menu > .menu").stop(true, true).animate({opacity: 'hide'}, 500).parents("li").removeClass("open_menu").children(".menu").animate({height:"hide"});
			*/
			$("#header-region #block-menu-primary-links > .content > .menu > .open_menu > .menu").stop(true, true).css({"display":"none"}, 500).parents("li").removeClass("open_menu").children(".menu").animate({height:"hide"});
			// and then fadeIn this menu
			$(this).addClass("open_menu");
			$(this).children('a').css({"color":"#035e80"});
			$(this).css({"background-color":"#FFF", "background-image":"none"});
			/* PREVIOUS ANIMATION
			$(this).children(".menu").css({"height":"auto"}).animate({opacity: 'show'}, 300, function(){ // next fadeIn, and secretly show the height
					$(this).animate({height: 'show'});
				});
			*/
			$(this).children(".menu").css({"height":"auto", "display":"block"});
			$(this).siblings(".tax_current").css({"background":"url(/img/nav-bg-dots_alpha.png) no-repeat top right"}).children("a").css({"color":"#FFFFFF"});
		} else {
			// if no other menus are open, then fadeIn and toggleHeight
			// FIRST: block any css stuff
			$(this).children(".menu").css({"display":"none"}).animate({height: 'hide'}, 0);
			$(this).css({"background":"url(/img/nav-bg-dots_alpha.png) no-repeat top right"});
			$(this).children("a").css({"color":"white"});
			// SECOND: setTimeout doesn't use 'this' as expected, so we need to make it a new variable...
			var this_button = $(this);
			timeoutID = window.setTimeout(function(){
				$(this_button).addClass("open_menu");
				$(this_button).children('a').css({"color":"#035e80"});
				$(this_button).css({"background-color":"#FFF", "background-image":"none"});
				$(this_button).children(".menu").animate({/*opacity: 'show', */height: 'show'}, 300);
				$(this_button).siblings(".tax_current").css({"background":"url(/img/nav-bg-dots_alpha.png) no-repeat top right"}).children("a").css({"color":"#FFFFFF"});
			}, 500);
		}
	});
	$("#header-region #block-menu-primary-links > .content > .menu > li").bind('mouseleave', function() {
			window.clearTimeout(timeoutID);
			// if no other menus are open, the fadeIn and toggleHeight
			$(this).children(".menu").css({"left":"0px"});
			$(this).children(".menu").stop(true, true).animate({/*opacity: 'hide', */height: 'hide'}, 300, "swing", function(){
				$(this).parents("li").removeClass("open_menu");
			}); 
			$(this).css({"background":"url(/img/nav-bg-dots_alpha.png) no-repeat top right"});
			$(this).children("a").css({"color":"white"});
			// MAINTAIN the current state for the prim nav button
			$("#header-region #block-menu-primary-links .menu .tax_current").css({"background":"none", "background-color":"#FFF"}).children("a").css({"color":"#202020"});
	});
	// END HEADER NAV ANIMATION
	// BEGIN SIDEBAR ANIMATION
	 /* CORRECT THE CSS VIA JS */
	$('#sidebar-left .clear-block .content .menu li:not(.active-trail) .menu').css("display","none");
	// MAKE THE URL javascript:; unless it is the Drupal Sidebar and the directory sidebars
	$("#sidebar-left .clear-block:not(#block-user-1, #block-block-20, #block-block-21, #block-block-22) .content .menu .expanded > a:first-child, .menu-822-b, #footer-region #block-menu-secondary-links .content .menu .menu-146, #footer-region #block-menu-secondary-links .content .menu .menu-147, #footer-region #block-menu-secondary-links .content .menu .menu-152, #footer-region #block-menu-secondary-links .content .menu .menu-153, #footer-region #block-menu-secondary-links .content .menu .menu-154, #footer-region #block-menu-secondary-links .content .menu .menu-155, .menu-177, .menu-184, .menu-185, .menu-186, .menu-179, .menu-198, .menu-205, .menu-209, .menu-214, .menu-219, .menu-220, .menu-222, .menu-223, .menu-227, .menu-229, .menu-231, .menu-233, .menu-235, .menu-237, .menu-238, .menu-239, .menu-243, .menu-245, .menu-247, .menu-249, .menu-536, .menu-537, .menu-538, .menu-539, .menu-624, .menu-625, .menu-626, .menu-600, .menu-564, .menu-601, .menu-602, .menu-612, .menu-617, .menu-562, .menu-563, .menu-566, .menu-565, .menu-571, .menu-583, .menu-591, .menu-6135, .menu-6136, .menu-6137, .menu-6134, .menu-6138, .menu-6141, .menu-6142, .menu-6143, .menu-6144, .menu-6504, .menu-6508, .menu-6509, .menu-6529").attr("href", "javascript:;");
	$('#sidebar-left .clear-block .content > .menu > li:not(.active-trail)').addClass("closed_menu");
	// Make links with "http://" open in a new window...
	$('a[href^="http://"]').attr("target", "_blank");
	// END SIDEBAR ANIMATION
	// MAKE MINI CALENDAR ON EVENT LISTING OPEN IN PARENT WINDOW
	$(".sidebars #wrapper #container #sidebar-right #block-views-calendar-calendar_block_1 .content .view .attachment .calendar-calendar .month-view table tr td div a").attr("target", "_parent");
	if( $("#wrapper").siblings().attr("id") == "admin-menu"){
		$("#wrapper").css({"margin-top":"22px"});
	}
	// BEGIN featured profile vertical center align
	$(".view-featured-profile-list .view-content .item-list ul .views-row .views-field-field-fp-image-fid img").load(function(){
		$.each($(this), function(){
			var big_daddy = $(this).parents(".views-row");
			var this_height = $(big_daddy).height();
			var this_image_height = $(big_daddy).find(".views-field-field-fp-image-fid img").height() + 11;
			var this_info_height = $(big_daddy).find(".views-field-title").height() + $(big_daddy).find(".views-field-field-fp-title-value").height() + $(big_daddy).find(".views-field-field-fp-email-email").height() + $(big_daddy).find(".views-field-body").height() + $(big_daddy).find(".views-field-field-fp-links-url").height();
			// alert("this_height = " + this_height + " and this_image_height = " + this_image_height);
			// alert("this_height = " + this_height + " and this_info_height = " + this_info_height);
			if(this_height > this_image_height){
				var add_this_margin = (this_height - this_image_height)/2;
				$(big_daddy).find(".views-field-field-fp-image-fid").css({"margin-top":add_this_margin});
			} else if(this_height > this_info_height){
				var add_this_margin = ((this_height - this_info_height)/2) -12;
				$(big_daddy).find(".views-field-title").css({"margin-top":add_this_margin});
			}
		});
	});
	// END featured profile vertical center align
	// BEGIN: in case related news is empty
	if($('#sidebar-left .view-id-News') && $('#sidebar-left .view-id-News .view-header').length == 0){
		$('#sidebar-left .view-id-News').css({"display":"none"});
	}
	// END: in case related news is empty
	// BEGIN: in case related events is empty
	if($('#sidebar-left .view-id-calendar') && $('#sidebar-left .view-id-calendar .view-header').length == 0){
		$('#sidebar-left .view-id-calendar').css({"display":"none"});
	}
	// END: in case related events is empty
	// BEGIN: FIXING 404 & 403, because they want a different title, but we need the title to work right in Drupal...
	if("#remove_other_h2"){
		$("#remove_other_h2").parents().siblings("h2").css({"display":"none"});
	}
	// END:   FIXING 404 & 403, because they want a different title, but we need the title to work right in Drupal...
	// BEGIN: make the orange bar on search results page have a specific class
	if($(".box .content .all_results dl.search-results")){
		$(".box .content .all_results dl.search-results").parents().find(".not_node_or_edit").children("#search-form").find("label").html("Refine your search");
		$(".box .content .all_results dl.search-results").parents().find("#squeeze").children(".help_section").addClass("special_search_bar");
		$(".box .content .all_results dl.search-results").parents().find("#squeeze").addClass("lets_move_this_searchbox");
		$.each($(".box .content .all_results dl.search-results").parents().find("#squeeze").children(".help_section").find("a"), function() { 
		  var this_link_inner = $(this).html();
		  $(this).parent("li").addClass(this_link_inner);
		});
	}
	// NO ReSULTS
	if($(".box .content ul.no_results")){
		$(".box .content  ul.no_results").parents().find("#squeeze").addClass("adjust_bc_no_results");
		$(".box").prepend("<h2 class='show_me'>Sorry, no results match your search</h2>");
		$("#search-form").find("label").html("Refine your search");
	}
	// NO RESULTS
	// END: make the orange bar on search results page have a specific class
}