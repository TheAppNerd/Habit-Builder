//
//  QuotesManager.swift
//  Habits
//
//  Created by Alexander Thompson on 9/2/22.
//

import UIKit


protocol QuotesManagerDelegate: AnyObject {
    func updateQuotes(_ quotes: [Quote] )
}


struct QuotesManager {
    
    weak var delegate: QuotesManagerDelegate?
    
    func parse()  {
        let decoder = JSONDecoder()
        let urlString = "https://type.fit/api/quotes"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            do {
                guard let data = data else { return }
                let quoteData = try decoder.decode([Quote].self, from: data)
                self.delegate?.updateQuotes(quoteData)
                
            } catch {
                print(String(describing: error))
            }
        }
        task.resume()
    }
    
}
