import Foundation
import UIKit

class CurrencyService {
    
    // Singleton pattern (isteğe bağlı)
    static let shared = CurrencyService()
    
    // API verisini çekme fonksiyonu
    func fetchCurrencyRates(completion: @escaping (Result<[String: Double], Error>) -> Void) {
        let urlString = "https://data.fixer.io/api/latest?access_key=1f41488d560b4d9221ce7ea476b33db6"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                
                // 'rates' verisini çözümleme
                if let rates = jsonResponse["rates"] as? [String: Double] {
                    completion(.success(rates))
                }
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
}


