//
//  CIvoire.swift
//  psr_api
//
//  Created by Mouhamed Camara on 7/15/20.
//  Copyright © 2020 PayDunya. All rights reserved.
//

import UIKit

class CIvoire: UIView
{
    //MARK: Outlets
        
    @IBOutlet weak var stackView: UIStackView!
            
    @IBOutlet weak var visaButton: addRoundingButton!
    
    @IBOutlet weak var mtnButton: addRoundingButton!
    
    @IBOutlet weak var omoneyButton: addRoundingButton!
    
    //MARK: Actions
    
    @IBAction func cartButton(_ sender: addRoundingButton)
    {
        if let visa = Bundle.main.loadNibNamed("Visa", owner: self, options: nil)?.first as? Visa
        {
        let y = stackView.frame.origin.y
        visa.frame.origin = CGPoint(x: 0, y: y + 70)
        visa.layer.borderWidth = 0.8
        visa.layer.borderColor = Colors.greyBorder?.cgColor
        visa.layer.cornerRadius = 5
//        visa.delegate = self
        self.addSubview(visa)
        }
        
        visaButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
        mtnButton.layer.borderColor = Colors.greyBorder?.cgColor
        omoneyButton.layer.borderColor = Colors.greyBorder?.cgColor
    }
    
    @IBAction func omoneyButton(_ sender: addRoundingButton)
    {
//        pd.removeFromSuperview()
//
        if let om = Bundle.main.loadNibNamed("OrangeMoneyCI", owner: self, options: nil)?.first as? OrangeMoneyCI
        {
            let y = stackView.frame.origin.y
            om.frame.origin = CGPoint(x: 0, y: y + 70)
            om.layer.borderWidth = 0.8
            om.layer.borderColor = Colors.greyBorder?.cgColor
            om.layer.cornerRadius = 5
            om.delegate = self
            self.addSubview(om)
        }
        
        
        
        visaButton.layer.borderColor = Colors.greyBorder?.cgColor
        mtnButton.layer.borderColor = Colors.greyBorder?.cgColor
        omoneyButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
    }
    
    
    @IBAction func mtnButton(_ sender: addRoundingButton)
    {
        if let mtn = Bundle.main.loadNibNamed("MTNCI", owner: self, options: nil)?.first as? MTNCI
        {
            let y = stackView.frame.origin.y
            mtn.frame.origin = CGPoint(x: 0, y: y + 70)
            mtn.layer.borderWidth = 0.8
            mtn.layer.borderColor = Colors.greyBorder?.cgColor
            mtn.layer.cornerRadius = 5
            mtn.delegate = self
            self.addSubview(mtn)
        }
//
        visaButton.layer.borderColor = Colors.greyBorder?.cgColor
        mtnButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
        omoneyButton.layer.borderColor = Colors.greyBorder?.cgColor
    }
    
    //MARK: Properties
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }

}

extension CIvoire: MTNCIDelegate, OMoneyCIDelegate
{
//    func paymentWithVisa(tel: String)
//    {
//        print("Voici est données de connexion pour Visa: \(tel)")
//    }
//    
    func paymentWithMTNCI(tel: String)
    {
        print("Voici est données de connexion pour MTN: \(tel)")
    }
    
    func paymentWithOMCI(tel: String)
    {
        print("Voici est données de connexion pour OrangeMoneyCI: \(tel)")
    }
    
}

