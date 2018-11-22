# Docker image for OpenCart with Becopay gateway


### Quick start

The easiest way to start OpenCart with MySQL is using [Docker Compose](https://docs.docker.com/compose/). Just clone this repo and run following command in the root directory. The default `docker-compose.yml` uses MySQL and phpMyAdmin.

```
$ docker-compose up -d
```

For admin username and password, please refer to the file `env`. You can also update the file `env` to update those configurations. Below are the default configurations.

```
MYSQL_HOST=db
MYSQL_ROOT_PASSWORD=myrootpassword
MYSQL_USER=ocbeco
MYSQL_PASSWORD=ocbeco
MYSQL_DATABASE=ocbecodb
DB_DRIVER=mysqli
DB_PORT=3306

ADMIN_EMAIL=admin@mail.com
ADMIN_USERNAME=admin
ADMIN_PASSWORD=Admin123456

BASE_URI=http://127.0.0.1/

```

For example, if you want to change the default currency, just update the variable `ADMIN_USERNAME`, e.g. `ADMIN_USERNAME=adminbeco`.


## Installation

After starting the container, you'll see the setup page of OpenCart. You can use the script `install-wordpress` to quickly install OpenCart. The installation script uses the variables in the `env` file.

### OpenCart

```
$ docker exec -it <container_name> install-opencart
```

### Database

The default `docker-compose.yml` uses MySQL as the database and starts [phpMyAdmin](https://www.phpmyadmin.net/). The default URL for phpMyAdmin is `http://localhost:8580`. Use MySQL username and password to log in.


## Configure the plugin

__Note :__ You must have a Becopay merchant account to use this plugin.  It's free and easy to [sign-up for a becopay merchant account](https://becopay.com/en/merchant-register/).

1. Connect to Opencart admin panel.

2. Go to this page
     `` Extensions -> Extensions ``
3. On __"Choose the extension type"__ select __"Payment"__  then click __"Filter"__
4. On payments list find __"Becopay payment Gateway"__ then click on green button(with plus icon) to install the plugin
5. Click on blue button(with pen icon) to editing plugin
6. On main configuration tab fill out the following fields:
   	* __Status__ - Select __"Enable"__ to enable Becopay Payment Gateway.
	* __Mobile Number__  - Enter the phone number you registered in the Becopay here.If you don't have Becopay merchat account register [here](https://becopay.com/en/merchant-register/).
	* __Api Base Url__  - Enter Becopay api base url here. If you don't have Becopay merchat account register [here](https://becopay.com/en/merchant-register/).
	* __Api Key__  - Enter your Becopay Api Key here. If you don't have Becopay merchat account register [here](https://becopay.com/en/merchant-register/).
	* __Sort Order__ - Your payment gateway ordering id.

3. Save changes.


## FAQ

### Where is the database?

OpenCart cannot run with a database. This image is for OpenCart only. It doesn't contain MySQL server. MySQL server should be started in another container and linked with OpenCart container. It's recommended to use Docker Compose to start both containers.

### Why getting access denied error after changing the default DB password?

If you change the default DB password in `env` file and get the access denied error when installing OpenCart.

## Becopay Support:

* [GitHub Issues](https://github.com/becopay/becopay-opencart/issues)
  * Open an issue if you are having issues with this plugin
* [Support](https://becopay.com/en/support/#contact-us)
  * Becopay support

## Contribute

Would you like to help with this project?  Great!  You don't have to be a developer, either.  If you've found a bug or have an idea for an improvement, please open an [issue](https://github.com/becopay/becopay-opencart/issues) and tell us about it.

If you *are* a developer wanting contribute an enhancement, bug fix or other patch to this project, please fork this repository and submit a pull request detailing your changes. We review all PRs!

This open source project is released under the [Apache 2.0 license](https://opensource.org/licenses/Apache-2.0) which means if you would like to use this project's code in your own project you are free to do so.  Speaking of, if you have used our code in a cool new project we would like to hear about it!  [Please send us an email](mailto:io@becopay.com).

## License

Please refer to the [LICENSE](https://opensource.org/licenses/Apache-2.0) file that came with this project.


