//
//  ViewController.swift
//  JSONFetcher
//
//  Created by nikita on 30.01.24.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet private var label: UILabel!
    
    private var table = "" {
        didSet {
            status += "\nCтол: \(table)\n"
        }
    }
    private var status = "" {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                label.text = status
            }
        }
    }

    @IBAction func buttonAction() {
        fetchGameTable()
    }
}

//MARK: - Networking
private extension MainViewController {
    func fetchGameTable() {
        let link = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1")!
        
        URLSession.shared.dataTask(with: link) { [weak self] data, _, error in
            guard let self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let gameTable = try JSONDecoder().decode(GameTable.self, from: data)
                print(gameTable)
                table = gameTable.deck_id
                fetchCardDesk()
            } catch {
                print(error.localizedDescription)
                table = error.localizedDescription
            }
        }.resume()
    }
    
    func fetchCardDesk() {
        let link = URL(string: "https://deckofcardsapi.com/api/deck/\(table)/draw/?count=5")!
        
        URLSession.shared.dataTask(with: link) { [weak self] data, _, error in
            guard let self else { return }
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let cardDesk = try JSONDecoder().decode(CardDeck.self, from: data)
                print(cardDesk)
                status += "Карты:\n" + cardDesk.cards.map { $0.value }.joined(separator: " | ")
            } catch {
                print(error.localizedDescription)
                status += error.localizedDescription
            }
        }.resume()
    }
    
    
}

