# DB Troubleshooting help

This application uses MySQL, with the full database being found in lcs2021.sql. The component files ( stored procedures, triggers, and raw data in .sqlite3 form ) can also be found in this directory.

To run this application, lcs2021.sql must be hosted and the settings.py file must be edited to provide proper authentication info.

	If the file is not loading, try removing all '/*!50017 DEFINER=`root`@`localhost`*/' tags.

	If django is having issues connecting to the database, a new migration may be needed. To do so:
		Navigate to the directory with manage.py
		$ python manage.py inspectdb > models.py
		$ python manage.py migrate
			* this may throw exceptions due to preexisting tables, but that shouldn't be an issue
		$ python manage.py runserver
		Data should now be displayed by the application