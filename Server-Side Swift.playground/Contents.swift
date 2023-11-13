/*:
 # Server Side Swift With Vapor
 With the availability of Swift on Linux systems, the logical next step was to develop a Swift-based "server".  Traditionally, a web server consists of a "stack" of software - an **http server** (to "talk" to the network), an **application server** (to provide the code logic to handle the http requests) and a **database** (to store the information.

 Several application server initiatives were started on Swift, but the one that survived is known as **Vapor**.  Vapor is available open source and the documentation can be found at [this site.](https://docs.vapor.codes)
 
 Getting up and running on Vapor is fairly straightforward, provided you get all the pre-reqs right and follow directions carefully.  Directions for installing Vapor on your Mac are located [here.](https://docs.vapor.codes/install/macos)
 * Use "brew" to install
 * Once installed, use "vapor --help" to test if it is working.
 
 It is generally best to do the original development work on your Mac, and have the localhost server (http port 127.0.0.1:8080) be where you test your server.
 
 Once you like the way your server is performing, you can move it to a virtual machine or a dedicated server.
 
 ## Additional components
 * [Postman](https://www.postman.com/downloads/) is a nice tool for testing your REST APIs as you are developing them
 * [Postgres](https://www.postgresql.org/) is the preferred database to use with Vapor, although others are supported
 * [Postico](https://eggerapps.at/postico2/) is a nice tool for managing your database
 
 ## Running a Vapor App
 To create a new app, bring up terminal in the folder where you want the app and type `vapor new hello-vapor`, where `hello-vapor` is the name of your app.
 * For a robust app, you should answer "y" when prompted if you want `Fluent` and `Leaf`.
 * `Fluent` is an *ORM* - Object to Relational Manager.  It allows you to map your Swift Objects to DB Tables.
 * `Leaf` is for creating server-side HTML pages.
 
 The App is initiated with `@main`, which in the latest version of Vapor is in a Swift file named `entrypoint`

 ### configure.swift
 `configure.swift` is where you configure your app.  For example, you need to add the database
````
app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
    hostname: Environment.get("DATABASE_HOST") ?? "localhost",
    port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
    username: Environment.get("DATABASE_USERNAME") ?? "postgres",
    password: Environment.get("DATABASE_PASSWORD") ?? "password",
    database: Environment.get("DATABASE_NAME") ?? "todo",
    tls: .prefer(try .init(configuration: .clientDefault)))
), as: .psql)
````
This is also where you initiate your *migrations*, *routes*, and *views*
 ### Migrations
 * A migration can define how you setup a database and how you can roll it back.
 * Migrations are generally stored in the "Migrations" folder in the project and called from configure.swift
 * A migration structure contains a `prepare` method for setup and a `revert` method for rollback.
 ### Routes
 * By default, `configure.swift` calls the function `routes` which is defined in `routes.swift`
 * Routes defines how the http requests (GET, PUT, etc) are routed in your server app.
 * Inside `routes.swift`, you can define routes, register route handlers, or both.
 * Route "handlers" are simply other swift files that generally reside in the "Controllers" folder.
 * The structures defined in one of these Controller files must follow the `RouteCollection` protocol which requires it to have a `boot` method.
 * The `boot` method registers the route handlers.
 ### Views
 * The **Views** in a server-side app are HTML pages.
 * Pages can be simple .html, or you can use a page server like *Leaf* to manage your pages.
 * NOTE:  Make sure you set the Working Directory in your Project Scheme to your Project Directory.  This will allow the app to find the right pages.
 * Create your pages in the Project under the "Resources->Views" folder (by default).
 * You can then reference these pages from your `routes.swift` or from your controllers.
 ### Models
 * The *Model* is where the magic happens in a Vapor app using Fluent
 * Fluent requires you to define Models for the objects you wish to store in the relational DB (Postgres, etc).
 * Models are defined in Swift files inside the "Models" folder by default
 * A Model must conform to two protocols:
    1. `Model` - which allows it to map to a relational DB
    1. `Content` - which ensures it can be encoded as JSON
 * Within the Model class, you use pre-defined Fluent **property wrappers** to manage the mapping between object and relational
*/
