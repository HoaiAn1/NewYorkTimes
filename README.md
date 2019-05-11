# NewYourTimes

*This is a demo for NYTimes APIs which applys **VIPER, POP, Core Data,** ...*

# VIPER
*This project will apply VIPER*

> VIPER is an application of Clean Architecture to iOS apps. The word VIPER is a backronym for View, Interactor, Presenter, Entity, and Routing.

* **View**: displays what it is told to by the Presenter and relays user input back to the Presenter.
* **Interactor**: contains the business logic as specified by a use case.
* **Presenter**: contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor).
* **Entity**: contains basic model objects used by the Interactor.
* **Routing**: contains navigation logic for describing which screens are shown in which order.

> I also use Repository pattern for Data Access Layer.

# AVC Kit
With objectives are to write **reusable**, **maintainable** and **testable** code. I introduce a new way of using UICollectionView, **ACVKit**, a lightweight collection view.

![](Images/ACVKit.png)

As your can see, from our data models, we will break down into corresponding section models. And each section model is backed by other item models and each item is corresponding to a cell. With this approach, you can easily reuse your cells. For instance, you already have an section model that contains 3 items: title, subtext, image. Then you wanna create a new section that also contain title, so your can attach the title item directly into your new section model. That's is easy to do.

> Pls take a look at my source code for reference.

# Project Structure:
## 3 main folders:
* [NewYourTimes](#newyourtimes-1)
* [NewYourTimesTests](#newyourtimestests)
* [NewYourTimesUITests](#head3)

### <a name="head1"></a>NewYourTimes
Contains App Bundle with 3 main folders:
* [Source](#head1.1) which contains all source code
* [Resources](#head1.2) which contains all resources such as: images, localizable strings,...
* [Supporting Files](#head1.3) which contains supporting files for the project: info.plist,...

#### <a name="head1.1"></a> Source
* **AppDelegate.swift** 
* **UI**: contains all UI related code
  * **Custom**: contains all custom UI
  * **Shared**: contains all shared UIs using across modules
  * **Screens**: contains all in-app screens
* **Components**: contains all backend related code
  * **Repositories**: contains all data access layers using in the project
  * ...
* **Common**: contains constants and utility methods that uses in the project

### <a name="head2"></a>NewYourTimesTests
Contains Unit Tests

### <a name="head3"></a>NewYourTimesUITests
Contains UI Tests
