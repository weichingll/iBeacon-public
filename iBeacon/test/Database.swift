//
//  Database.swift
//  test
//
//  Created by 呂長霖 on 2024/5/2.
//

import Foundation

class data_link : ObservableObject{
    let user_url = URL(string: "https://api.airtable.com/v0/app5fKBa04lBdINdG/User")!
    let beacon_url = URL(string: "https://api.airtable.com/v0/app5fKBa04lBdINdG/beacon")!
    let token = "patUj5oLB517zr16T.24c0a004222f170f7d7642dd83bc9022d28a67dc6d4da0487153e22fe48656e1"
    
    func uploadData(_ userdata: database_user){
        var request = URLRequest(url: user_url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        encoder.dateEncodingStrategy = .formatted(formatter)
        request.httpBody = try? encoder.encode(userdata)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data,
              let  _ = String(data: data, encoding:  .utf8){
                
                }
        }.resume()
    }
    
    func loadData_Account(completion: @escaping([String]) -> Void){
        var Account_data = [String]()
        var request = URLRequest(url: user_url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let data_source = try decoder.decode(database_user.self, from: data)
                
                for record in data_source.records{
                    let account = record.fields.user
                    Account_data.append(account)
                }
                completion(Account_data)
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func loadData_Beacon(completion: @escaping([String]) -> Void){
        var Beacon_uuid_data = [String]()
        var request = URLRequest(url: beacon_url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let data_source = try decoder.decode(database_beacon.self, from: data)
                
                for record in data_source.records{
                    let uuid = record.fields.uuid
                    Beacon_uuid_data.append(uuid)
                }
                completion(Beacon_uuid_data)
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct database_user: Codable{
    let records: [Record]
    
    struct Record: Codable{
        let fields: Fields
    }
    
    struct Fields: Codable{
        let user: String
        let password: String
        let name: String
        let date: Date
        let email: String
    }
}

struct database_beacon: Codable{
    let records: [Record]
    
    struct Record: Codable{
        let fields: Fields
    }
    
    struct Fields: Codable{
        let uuid: String
    }
}

