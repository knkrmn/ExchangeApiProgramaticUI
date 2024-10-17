//
//  CustonText.swift
//  ExchangeApiProgramaticUI
//
//  Created by Okan Karaman on 17.10.2024.
//

import UIKit

class CustomText: UILabel {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text :String){
            self.init(frame: .zero)
        set(text: text)
    }
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textColor = UIColor.systemBlue
        textAlignment = .center
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    private func set(text : String?){
        self.text = text ?? "Welcome to app"
    }

}
