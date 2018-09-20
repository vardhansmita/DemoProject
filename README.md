# 20180825-SmitaVardhan-NYCSchools


This is an mobile client application for [NYCSchools](https://data.cityofnewyork.us/Education/DOE-High-School-Directory-2017/s3k6-pzi2). NYCSchools app displays list of NYC Schools and then shows additional information about the school like SAT scores in various categories. It is written in Swift 4 and XCode 9.4. It uses a simple restful service to get data from the server and display it in a list format in a tableview.



## Documentation
1.After downloading this project run pod install to download the Pods folder.
2.The app is currently designed using Apples MVC pattern but can be modified into MVVM also.
3.The end point for getting the data from server is customized for pagination but because of less time I could not implement pagination in the tableview. So, Right now the app is only showing data for 100 rows but if paging is done it will show more data depending on the offset.
4.The app also tests the model classes and similarly can be used to test the networking code also.
5.This app uses Alamofire version 4.7 for making networking calls and SVProgressHud for loding indicator using cocoapods 

<img width="356" alt="screen shot 2018-09-11 at 12 23 27 pm" src="https://user-images.githubusercontent.com/1837575/45382788-2d1ba400-b5be-11e8-8fa7-12d77645dea0.png">
<img width="343" alt="screen shot 2018-09-11 at 12 23 39 pm" src="https://user-images.githubusercontent.com/1837575/45382789-2d1ba400-b5be-11e8-9dea-389269280694.png">
