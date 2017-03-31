//This file will be used as a reference to Get, Post, and Put DB data using the alamo fire library.
import Swift
import Alamofire
import SwiftyJSON

// I like that you're utilzing Alamofire and you've got SwiftyJSON here as it comes in handy saving us from writing a bunch of JSON parsing boilerplate

// And I like that you've separated off into a separate class for your server calls here.

// We'll be creating an API or Network Class and some support classes that will make working with the APIs clear, robust, and convenient. We'll have classes that represent the data expected/required by each API call, and also classes to representing what is returned by each call, including convenience methods for generating payloads and also for parsing responses into the aforementioned response objects. We'll also be implement support for error handling in these classes too.

//Function to create a Flight
func CreateFlight(past: Bool, departureTime: String, arrivalTime: String, distance: Int, cost: Int, origin: String, destination: String) {
    let parameters: Parameters = [
        "past": past,
        "departureTime": departureTime,
        "arrivalTie": arrivalTime,
        "distance": distance,
        "cost": cost,
        "origin": origin,
        "destination": destination,
    ]
    
    let postRequest = Alamofire.request("http://localhost:3000/add-flight", method: .post, parameters: parameters)
    print(postRequest)

}

//Function to create a User
func CreateUser(firstName: String, lastName: String, email: String, password: String, phone:String, birthDay: String) {
    let parameters: Parameters = [
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "birthDay": birthDay
                ]
    
    let postRequest = Alamofire.request("http://localhost:3000/add-user", method: .post, parameters: parameters)
    print(postRequest)
    
}


//Function to Get all Users
func GetUserData() {
    let serverEndpoint: String = "http://localhost:3000/get-user"
    Alamofire.request(serverEndpoint)
    .responseJSON { response in
        // check for errors
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            print("error calling GET")
            print(response.result.error!)
            return
        }
    
        // make sure we got some JSON since that's what we expect
        guard (response.result.value as? [String: Any]) != nil else {
            print("didn't get todo object as JSON from API")
            print("Error: \(response.result.error)")
            return
        }
    
        // get and print
        let data = response.result.value!
        print(data)
    }

}

//Function to Get all Flights
func GetFlightData() {
    let serverEndpoint: String = "http://localhost:3000/get-flight"
    Alamofire.request(serverEndpoint)
        .responseJSON { response in
            // check for errors
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET")
                print(response.result.error!)
                return
            }
            
            // make sure we got some JSON since that's what we expect
            guard (response.result.value as? [String: Any]) != nil else {
                print("didn't get todo object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            
            // get and print
            let data = response.result.value!
            print(data)
    }
    
}
