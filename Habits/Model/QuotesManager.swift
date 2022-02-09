//
//  QuotesManager.swift
//  Habits
//
//  Created by Alexander Thompson on 9/2/22.
//

import UIKit

struct QuotesManager {
    
    
    
    func parse() -> [Quote] {
        let decoder = JSONDecoder()
        let urlString = "https://type.fit/api/quotes"
        var quotes = [Quote]()
        guard let url = URL(string: urlString) else { return [] }
       
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            do {
                
                guard let data = data else { return }
                let quoteData = try decoder.decode(Quotes.self, from: data)
                quotes = quoteData.quotes
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
      return quotes
    }
}
