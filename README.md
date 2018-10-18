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

Open the project folder in terminal and update swift package and vapor.

```
swift package update
vapor update -y
```

After updating, the project will be opened in xcode.

Before running the project. Make sure MongoDB is installed on your machine.
Installing MongoDB via bew
```
brew update
brew install mongodb
```
Next you need to create the db folder for MongoDB to store the databases and check the permissions for the db folder.
```
mkdir -p /data/db
sudo chown -R `id -un` /data/db
```

Run the MongoDB,
```
mongod
```

Now, run the project on xcode.

## Testing the project

I suggest using [Postman (API Development Environment)](https://www.getpostman.com/) to perform the `GET` and `POST` requests.

- `POST` request,
perform a post request to the following url: 
```
http://localhost:8080/todos
```
and set the following two keys and values in the body,

| key   | value |
| ----- | ----- |
|  id   | 1     |
| title | Hi! |

- `GET` request,
perform a get request to the following url:
```
http://localhost:8080/todos
```
you should see the created todo from the `GET` request.

Note: If there are no key and values in the body of the post request. You will see the following error,
```
[ ERROR ] Abort.415: No 'Content-Type' header is present. ContentContainer.swift:320)
```