//
//  ViewController.swift
//  ExchangeApiProgramaticUI
//
//  Created by Okan Karaman on 17.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var head       = CustomText(text : "ExChange App!")
    lazy var euro       = CustomText(text : "Now 1 Euro is")
    lazy var dolar      = CustomText(text : "$ USD  ")
    lazy var sterlin    = CustomText(text : "£ GBP  ")
    lazy var grivna     = CustomText(text : "₴ UAH  ")
    lazy var yen        = CustomText(text : "₺ TRY  ")
    lazy var florin     = CustomText(text : "Ft HUF ")
    
    let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Arka plan rengi
        button.backgroundColor = .systemGray5
        
        // Gölge ekleyelim
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
        
        // Kenarları yuvarlak yapalım
        button.layer.cornerRadius = 15
        
        // Metin ve renkler
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Refresh", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    lazy var homepageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[head,euro,dolar,sterlin,grivna,yen,florin,refreshButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    func setupUI () {
        view.backgroundColor = .systemGray3
        configureStackView()
        getData()
    }
    
    func configureStackView(){
            view.addSubview(homepageStackView)
            homepageStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                homepageStackView.topAnchor.constraint(equalTo:
                 view.safeAreaLayoutGuide.topAnchor,constant: 30),
                homepageStackView.leadingAnchor.constraint(equalTo:
                 view.leadingAnchor, constant: 30),
                homepageStackView.trailingAnchor.constraint(equalTo:
                 view.trailingAnchor, constant: -30),
    ]) }
    
    func getData(){
        CurrencyService.shared.fetchCurrencyRates { [weak self] result in
            switch result {
            case .success(let rates):
                DispatchQueue.main.async {
                    // Etiketleri güncelleme
                    if let usd = rates["USD"] {
                        self?.dolar.text = "\(String(usd).prefix(5)) $ USD"
                    }
                    if let gbp = rates["GBP"] {
                        self?.sterlin.text = "\(String(gbp).prefix(5)) £ GBP"
                    }
                    if let uah = rates["UAH"] {
                        self?.grivna.text = "\(String(uah).prefix(5)) ₴ UAH"
                    }
                    if let jpy = rates["JPY"] {
                        self?.yen.text = "\(String(jpy).prefix(5)) ¥ JPY"
                    }
                    if let huf = rates["HUF"] {
                        self?.florin.text = "\(String(huf).prefix(5)) Ft HUF"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    

    
    
}

