# Bachat

**Your one stop shop to all rewards - anyplace, anywhere, anytime**

![Mockup](/screenshots/main.jpg)
**Freelance Project**
**Project Duration - July 2019 - Sept 2019**
***
Bachat is an Android and iOS mobile application, that allows users to view offers available from different rewards programs, all in a single application. Gone are the days where users have to install one application for each bank/restaurant/mobile carrier rewards program.

## Architecture

The application is made up of the following components:
* [Frontend Application](https://flutter.dev//) - Built using Flutter, a UI toolkit founded by Google, for building beautiful, natively compiled applications, for both Android and iOS platforms
* Home Server - Used to run scripts that automatically scrape data off the rewards websites, and used to upload to a database that will be used by the REST endpoint - **[Backend repository](https://github.com/hussu97/bachat-scraping)**
* [AWS Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/) - Deploying the REST endpoint that is being used by the application - **[Scraping repository](https://github.com/hussu97/bachat-backend)**
* [AWS RDS](https://aws.amazon.com/rds/) - PostGreSQL Database used to store data about the rewards programs, which will be accessed by the mobile application throught the REST endpoint 

## Requirements
* Flutter Toolkit
* An amazon AWS account
* Android/iOS device
* Android Studio (if running on Android)
* Macbook (if running on iOS)
* XCode (if running on iOS)

## Installation
1. Clone the repo by using the following command
``` bash
$ git clone https://github.com/hussu97/bachat.git
$ cd bachat
```
2. Open the project in Visual Studio Code or Android Studio
3. Build and run the application on your mobile device of choice, or an emulator
4. For details on how to build flutter applications, check out this [link](https://flutter.dev/docs/get-started/install)


## Functions
* Select which rewards programs you wish to see information about on the application
* Search for available offers for a particular company
* Search for offers based on category
* Search for offers based on rewards program
* Search for offers based on emirate
* Search for offers on a map, and find offers near you (requires location permission)

## Additional Screenshots
![s1](/screenshots/s1.jpg)
![s2](/screenshots/s2.jpg)
![s3](/screenshots/s3.jpg)
![s4](/screenshots/s4.png)
![s5](/screenshots/s5.png)
***
## License
[Apache License 2.0](https://github.com/hussu97/bachat/blob/master/LICENSE)
