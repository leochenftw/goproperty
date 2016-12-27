<?php
	define('SS_ENVIRONMENT_TYPE', 'dev');
	/**
	 * The database class to use, MySQLDatabase, MSSQLDatabase, etc. defaults to MySQLDatabase
	 */
	define('SS_DATABASE_CLASS', 'MySQLDatabase');

	/**
	 * The database server to use, defaulting to localhost
	 */
	define('SS_DATABASE_SERVER', 'localhost');

	/**
	 * The database username (mandatory)
	 */
	define('SS_DATABASE_USERNAME', 'silverstripe');

	/**
	 * The database password (mandatory)
	 */
	define('SS_DATABASE_PASSWORD', 'nU3asT52uwUb');

	/**
	 * Set the database name.
	 * Assumes the $database global variable in your config is missing or empty.
	 */
	define('SS_DATABASE_NAME', 'ss_silverstripe');

	define('SS_ERROR_LOG', __DIR__ . '/silverstripe.log');

	/* Configure a default username and password to access the CMS on all sites in this environment. */
	define('SS_DEFAULT_ADMIN_USERNAME', 'defaultadmin');
	define('SS_DEFAULT_ADMIN_PASSWORD', 'passw0rd');


	global $_FILE_TO_URL_MAPPING;
	$_FILE_TO_URL_MAPPING[__DIR__] = 'http://ss_site.local';