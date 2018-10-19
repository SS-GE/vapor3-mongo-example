<p align="center">
    <img src="https://user-images.githubusercontent.com/1342803/36623515-7293b4ec-18d3-11e8-85ab-4e2f8fb38fbd.png" width="320" alt="API Template">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="https://discord.gg/vapor">
        <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/api-template">
        <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</center>

## Getting started

Open the project folder in terminal and sync up.

```
swift package update                   # update dependencies
swift package generate-xcodeproj       # regenerate Xcode project
open *.xcodeproj                       # open Xcode
```

Before running the project, make sure MongoDB is installed on your machine and is running.

### Option 1: Docker

Assuming you have [Docker for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac) installed and running, create a new MongoDB container with:

```
docker run --name example-mongo -p 27017:27017 mongo:latest
```

Or if you've done this once, start the existing container:

```
docker start example-mongo
```

### Option 2: Installing MongoDB via Homebrew

```
brew update
brew install mongodb
```

Next, create the db folder for MongoDB to store the databases and check the permissions for the db folder:

```
mkdir -p /data/db
sudo chown -R `id -un` /data/db
```

Launch the MongoDB server:
```
mongod
```

Now, run the project on xcode.

## Testing the project

### Using Postman

The [Postman (API Development Environment)](https://www.getpostman.com/) is a neat tool for setting up and performing HTTP requests repeatably.

#### Creating a Todo

Create a POST request to the following URL: 
```
http://localhost:8080/todos
```

And set the following two keys and values in the body:

| key   | value |
| ----- | ----- |
|  id   | 1     |
| title | Hi! |

Note: If there are no key and values in the body of the post request, you will see the following error:
```
[ ERROR ] Abort.415: No 'Content-Type' header is present. ContentContainer.swift:320)
```

#### Getting the Todo list

Create a GET request to the following URL:
```
http://localhost:8080/todos
```

You should see the created Todo from the `POST` request.
