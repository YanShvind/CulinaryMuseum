# CulinaryMuseum

CulinaryMuseum is an iOS application that provides users with a comprehensive collection of recipes. The app supports fetching recipes from a remote server using URLSession, and it follows the MVVM architectural pattern. The app uses Hasher and Dispatch Group to ensure data consistency, while protocols and delegates are used for communication between components. The app also supports data persistence using CoreData, and it makes extensive use of composition, collection, table view, footer, and CoreImage to implement the user interface.

* MVVM
* URLSession
* CoreData
* Dispatch group, Hasher, CoreImage
* Protocols, Delegates, Clusures
* CompositionLayout, CollectionView, TableView

# Features

* The app allows users to browse a wide selection of recipes.
* Detailed recipe information is provided, including a list of ingredients, preparation instructions, and nutritional information.
* The app allows users to save their favorite recipes for easy access later.
* Users can create and edit their own personal recipe collection.
* Recipe images are processed using CoreImage to improve their quality and make them more visually appealing.

# Architecture

The app follows the MVVM architectural pattern, separating the presentation layer from the business logic and data access layer. The ViewModel communicates with the View through protocols and delegates, and it uses Hasher and Dispatch Group to ensure data consistency between the Model and the View.

# Data Persistance

The app uses CoreData to provide data persistence, providing users with the ability to save and manage their personal recipe collection.

# User Interface

The app provides a rich user interface, making use of composition, collection, table view, footer, and CoreImage to provide users with a visually engaging and intuitive experience.

![1-2](https://user-images.githubusercontent.com/58136391/233460504-f18021cd-9b30-4311-840d-35b5284f4984.png)

# Requirements

* iOS 13.0+
* Xcode 10.0+
* Swift 5+

# Installation

* Clone the repository
* Open the CulinaryMuseum.xcodeproj file in Xcode
* Insert your api key(https://spoonacular.com/food-api)
* Build and run the app
