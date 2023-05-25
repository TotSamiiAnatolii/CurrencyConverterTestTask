//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by APPLE on 21.05.2023.
//

import UIKit

protocol NetworkServiceProtocol: AnyObject {
    
    func getRates(from: String, to: String, completion: @escaping((Result<RatesModel, Error>) -> Void))
    
    func getListCurrency(completion: @escaping((Result<ModelListCurrency, Error>) -> Void))
    
    var currencyCache: CurrencyCache { get set }
}

final class NetworkManager: NetworkServiceProtocol {
    
    var currencyCache = CurrencyCache(previusDate: Date())
    
    func getRates(from: String, to: String, completion: @escaping ((Result<RatesModel, Error>) -> Void)) {
        
        if let value = currencyCache.returnData(key: "\(from)\(to)") {
            completion(.success(value))
            return
        }
        let urlString = "\(ApiUrl.rate.rawValue)\(from)\(to)\(ApiUrl.key.rawValue)"
        
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: url) else {
            print("Error")
            return
        }
        fetchModels(from: url, in: completion)
    }
    
    func getListCurrency(completion: @escaping ((Result<ModelListCurrency, Error>) -> Void)) {
        let urlString = ApiUrl.listCurrency.rawValue + ApiUrl.key.rawValue
        
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: url) else {
            print("Error")
            return
        }
        fetchModels(from: url, in: completion)
    }
    
    private func fetchModels<T: Decodable>(from url: URL, in completion: @escaping ((Result<T, Error>) -> Void)) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            }
            catch {
                completion(.failure(error))
                print("decode error: \(error)")
            }
        }.resume()
    }
}
