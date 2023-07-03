import UIKit
import HTTPService
import Combine



class doIt {
    
    var http = HTTPService()
    var json: Data? = nil
    
    
    init() {
    }
    
    func getData() {
        print("before sleep")
        self.json = http.loadJson(url: "https://jsonplaceholder.typicode.com/todos/1")
        sleep(3)
        print("after sleep")
    }
    
}

struct Todos: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

let fetch = doIt()
fetch.getData()

