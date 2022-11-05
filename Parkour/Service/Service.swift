//
//  Service.swift
//  Parkour
//
//  Created by Sebastian Ederer on 27.10.22.
//

import Foundation
import Combine
import SwiftUI

class Gateway {
    func getSpots() -> AnyPublisher<[Spot], Error> {
        let url = self.getFullUrl(subpath: "/spots/all")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map{ $0.data }
            .mapError { $0 as Error }
            .decode(type: [Spot].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getSpot(id: Int) -> AnyPublisher<Spot, Error> {
        let url = self.getFullUrl(subpath: "/spots/\(id)")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map{ $0.data }
            .mapError { $0 as Error }
            .decode(type: Spot.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getSpotUser(id: Int) -> AnyPublisher<User, Error> {
        let url = self.getFullUrl(subpath: "/spots/\(id)/user")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map{ $0.data }
            .mapError { $0 as Error }
            .decode(type: User.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func rateSpot(spotId: Int, stars: Int, comment: String) -> AnyPublisher<Rating, Error> {
        var url = self.getFullUrl(subpath: "/rating/spot")
        url!.append(queryItems: [URLQueryItem(name: "spot", value: "\(spotId)")])
        var requestURL = URLRequest(url: url!)
        requestURL.httpMethod = "POST"
        let body : [String: Any] = [
            "stars": stars,
            "comment": comment
        ]
        requestURL.addValue("application/json", forHTTPHeaderField: "content-type")
        requestURL.httpBody = try! JSONSerialization.data(withJSONObject: body)
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .mapError { $0 as Error}
            .map { $0.data }
            .decode(type: Rating.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func login(username: String, password: String) -> AnyPublisher<Token, Error> {
        let url = self.getFullUrl(subpath: "/login")
        var requestURL = URLRequest(url: url!)
        requestURL.httpMethod = "POST"
        let body : [String: Any] = [
            "username": username,
            "password": password
        ]
        requestURL.addValue("application/json", forHTTPHeaderField: "content-type")
        requestURL.httpBody = try! JSONSerialization.data(withJSONObject: body)
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .mapError { $0 as Error}
            .map { $0.data }
            .decode(type: Token.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func register(username: String, password: String) -> AnyPublisher<User, Error> {
        let url = self.getFullUrl(subpath: "/user/create")
        var requestURL = URLRequest(url: url!)
        requestURL.httpMethod = "POST"
        let body : [String: Any] = [
            "username": username,
            "password": password
        ]
        requestURL.addValue("application/json", forHTTPHeaderField: "content-type")
        requestURL.httpBody = try! JSONSerialization.data(withJSONObject: body)
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .mapError { $0 as Error}
            .map { $0.data }
            .decode(type: User.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func verifyToken() -> AnyPublisher<Verify, Error> {
        let url = self.getFullUrl(subpath: "/token/verify")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map{ $0.data }
            .mapError { $0 as Error }
            .decode(type: Verify.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getFullUrl(subpath: String) -> URL! {
        let fullUrl = "http://localhost:8080/api" + subpath
        guard let token = UserDefaults.standard.string(forKey: "token") else {return URL(string: fullUrl)!}
        var url = URL(string: fullUrl)!
        url.append(queryItems: [URLQueryItem(name: "token", value: token)])
        return url
    }
    
    func createSpot(latitude: Double, longitude: Double, city: String) -> AnyPublisher<Spot, Error>{
        let url = self.getFullUrl(subpath: "/user/post-spot")
        var requestURL = URLRequest(url: url!)
        requestURL.httpMethod = "POST"
        let body : [String: Any] = [
            "latitude": latitude,
            "longitude": longitude,
            "city": city,
            "description": "Nix",
            "spotType": "freerunning",
        ]
        requestURL.addValue("application/json", forHTTPHeaderField: "content-type")
        requestURL.httpBody = try! JSONSerialization.data(withJSONObject: body)
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .mapError { $0 as Error}
            .map { $0.data }
            .decode(type: Spot.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getUserByToken() -> AnyPublisher<User, Error> {
        let url = self.getFullUrl(subpath: "/user")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map{ $0.data }
            .mapError { $0 as Error }
            .decode(type: User.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    typealias HTTPHeaders = [String: String]
    var headers: HTTPHeaders {
        return [
            "Content-Type": "multipart/form-data; boundary=\(boundary)",
            "Accept": "application/json"
        ]
    }
    
    func addImageToSpot(image: UIImage, id: Int) -> AnyPublisher<ImageResponse, Error>{
        let url = self.getFullUrl(subpath: "/images/\(id)")
        
        let imageData = image.jpegData(compressionQuality: 1)!
        let mimeType = imageData.mimeType!

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = createHttpBody(binaryData: imageData, mimeType: mimeType)
        

        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { $0 as Error}
            .map { $0.data }
            .decode(type: ImageResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func setUserProfilePic(image: UIImage) -> AnyPublisher<String, Error>{
        let url = self.getFullUrl(subpath: "/user/profile")
        
        let imageData = image.jpegData(compressionQuality: 1)!
        let mimeType = imageData.mimeType!

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = createHttpBody(binaryData: imageData, mimeType: mimeType)

        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { $0 as Error}
            .map { $0.data }
            .decode(type: String.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getProfilePic(username: String) -> URL {
        return URL(string: "http://localhost:8080/api/user/profile/\(username)")!
    }
    
    func getImage(id: Int) -> URL {
        return URL(string: "http://localhost:8080/api/images/\(id)")!
    }
    

    let boundary = "example.boundary.\(ProcessInfo.processInfo.globallyUniqueString)"

    private func createHttpBody(binaryData: Data, mimeType: String) -> Data {
        var postContent = "--\(boundary)\r\n"
        let fileName = "\(UUID().uuidString).jpeg"
        postContent += "Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\r\n"
        postContent += "Content-Type: \(mimeType)\r\n\r\n"

        var data = Data()
        guard let postData = postContent.data(using: .utf8) else { return data }
        data.append(postData)
        data.append(binaryData)

        guard let endData = "\r\n--\(boundary)--\r\n".data(using: .utf8) else { return data }
        data.append(endData)
        return data
    }
}


extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}


struct ImageResponse: Codable, Hashable {
    let id: Int;
}

extension Data {
    var bytes: [UInt8] {
        return [UInt8](self)
    }
}


struct Token: Codable, Hashable {
    let token: String?
}

struct LoginCredentials: Codable, Hashable {
    let username: String
    let password: String
}

struct Verify: Codable, Hashable {
    let verified: Bool
}

extension Data {

    var mimeType: String? {
        var values = [UInt8](repeating: 0, count: 1)
        copyBytes(to: &values, count: 1)

        switch values[0] {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        default:
            return nil
        }
    }
}
