<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
		<% base_tag %>
		$MetaTags(true)
		<% include OG %>
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
        <link href="https://fonts.googleapis.com/css?family=Lato:400,400i,700,700i&amp;subset=latin-ext" rel="stylesheet">

		$getCSS

		<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>

		<% include GA %>
        <script src='https://www.google.com/recaptcha/api.js'></script>
	</head>
	<body class="page-$URLSegment.LowerCase<% if $isMobile %> mobile<% end_if %> page-type-$BodyClass.LowerCase<% if $extraBodyClassName %> $extraBodyClassName<% end_if %>">
		<% include Header %>

		<main id="main">
            <% if $HomepageHero %>
            <% include PageHero %>
            <% end_if %>
			$Layout
		</main>

		<% include Footer %>
        <% if $BodyClass.LowerCase == 'property-page' || $BodyClass.LowerCase == 'business' %>
            <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-58e5d87b19265d9e"></script>
        <% end_if %>
	</body>
</html>
