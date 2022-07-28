import Foundation

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = true
    configuration.waitsForConnectivity = true
    configuration.timeoutIntervalForRequest = 15.0
    configuration.timeoutIntervalForResource = 20.0

    guard let url = urlRequest else {
        print("Incorrect adress")
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        //Errors
        if error != nil {
            print("Error: \((error as! URLError).errorCode).")
            if (error as! URLError).code == URLError.cannotConnectToHost {
                print("An attempt to connect to a host failed.")
            }
            if (error as! URLError).code == URLError.notConnectedToInternet {
                print("A network resource was requested, but an internet connection hasn’t been established and can’t be established automatically.")
            }
            if (error as! URLError).code == URLError.badServerResponse {
                print("The URL Loading System received bad data from the server.")
            }
            if (error as! URLError).code == URLError.dnsLookupFailed {
                print("The host address couldn’t be found via DNS lookup.")
            }
        //Answer
        } else if let response = response as? HTTPURLResponse {
            print("Status code: \(response.statusCode)")

            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString ?? "")
        }
    }.resume()
}

let rickSanchezUrl = "https://rickandmortyapi.com/api/character/1"
getData(urlRequest: rickSanchezUrl)
