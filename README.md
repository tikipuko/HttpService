# HTTPService

###### HTTP Service is a _**SWIFT**_ package that can manage your network requests using _**Combine**_ and help you build your URL and URLRequests with custom methods. It also can returns the pretended data, or handle network connection errors.

### To get your data you simply need to make 3 steps
1. Build your URL
2. Build your URLRequest
3. Process your request an handle the return Data on cliente side.
###### With this steps and our custom methods you easily handle objects or images.

## METHOD urlBuilder()
requestBuilder is a custom method to help you setting your URL() type variable.

* You can build your URL with an absolute string url using:

> Parameter: 

>> url: Absolute URL:  String

> Returns: URL that enables you to build your URLRequest
``` 
func urlBuilder(url: String) -> URL
```

* You can build your URL dissecting the components for the most complex URL's using: 

> Parameters:

>> url: URL from where you pretend to make your request.

> Returns: URL to enable your URLRequest
```
func urlBuilder(scheme: String, host: String, path: String, queryItems: [URLQueryItem]) -> URL
```

## METHOD urlRequest()

urlRequest() is a custom method that builds your request with the parameters that you need.

> Parameters:

>> url: URL from where you pretend to make your request.

>> method: request method if needed, like "GET", "POST, "PUT"..

>> key: API secret key, if needed.

>> header: API request message, if needed.

> Returns: URLRequest to enable your request.
```
func requestBuilder(url: URL, method: String? = nil, key: String? = nil, header: String? = nil) -> URLRequest
```

## METHOD processRequest()

processRequest() is the network engine that returns a publisher of type data or error

> Parameter:

>> urlRequest: urlRequest setted that enable you to make your request

> Returns: Publisher type Data or Error if there is any connection problem, that Data still needs to be transformed on the cliente side.
```
func processRequest(urlRequest: URLRequest) -> AnyPublisher<Data, Error>
```

## Handling on Client Side Step by Step 

1. Import HTTPService
2. Instantiate HTTPService
3. Setup your URL
4. Setup your URLRequest
5. Execute the request and handle the data.

```
import HTTPService
let http = HTTPService()
let url = http.urlBuilder(url: "your url")
let urlRequest = http.requestBuilder(url: url)

http.processRequest(urlRequest: urlRequest)
    .receive(on: RunLoop.main)
        .sink(receiveCompletion: { _ in
            //HANDLE PROMISE
        }, receiveValue: { data in
            do {
                /// in case to handle json
                self.myData = try JSONDecoder().decode(YourStruct.self, from: data)  
                /// in case to handle imageView
                self.picture.image = UIImage(data: data)                               
            } catch {
                 print("Handle Decoder Error")
            }
        })
        .store(in: &cancellables)
```
