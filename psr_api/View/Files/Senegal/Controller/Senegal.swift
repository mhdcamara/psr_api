//
//  Senegal.swift
//  psr_api
//
//  Created by Mouhamed Camara on 7/7/20.
//  Copyright © 2020 PayDunya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class Senegal: UIView
{
    //MARK: Outlets
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var paydunyaButton: addRoundingButton!
    
    @IBOutlet weak var visaButton: addRoundingButton!
    
    @IBOutlet weak var wariButton: addRoundingButton!
    
    @IBOutlet weak var omoneyButton: addRoundingButton!
    
    //MARK: Actions
    
    @IBAction func paydunyaButton(_ sender: addRoundingButton)
    {
        if let pd = Bundle.main.loadNibNamed("PayDunya", owner: self, options: nil)?.first as? PayDunya
        {
            let y = stackView.frame.origin.y
            pd.frame.origin = CGPoint(x: 0, y: y + 70)
            pd.layer.borderWidth = 0.8
            if #available(iOS 13.0, *)
            {
                pd.layer.borderColor = UIColor.systemGray4.cgColor
            }
            else
            {
                
            }
            if #available(iOS 11.0, *)
            {
                pd.layer.borderColor = Colors.greyBorder?.cgColor
            }
            else
            {
                // Fallback on earlier versions
            }
            
            pd.layer.cornerRadius = 5
            pd.delegate = self
            pdunya = pd
            self.addSubview(pdunya)
        }
        
        paydunyaButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
        visaButton.layer.borderColor = Colors.greyBorder?.cgColor
        wariButton.layer.borderColor = Colors.greyBorder?.cgColor
        omoneyButton.layer.borderColor = Colors.greyBorder?.cgColor
    }
    
    @IBAction func cartButton(_ sender: addRoundingButton)
    {
        if let visa = Bundle.main.loadNibNamed("Visa", owner: self, options: nil)?.first as? Visa
        {
            let y = stackView.frame.origin.y
            visa.frame.origin = CGPoint(x: 0, y: y + 70)
            visa.layer.borderWidth = 0.8
            visa.layer.borderColor = Colors.greyBorder?.cgColor
            visa.layer.cornerRadius = 5
//            visa.delegate = self
            self.addSubview(visa)
        }
        
        paydunyaButton.layer.borderColor = Colors.greyBorder?.cgColor
        visaButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
        wariButton.layer.borderColor = Colors.greyBorder?.cgColor
        omoneyButton.layer.borderColor = Colors.greyBorder?.cgColor
    }
    
    @IBAction func omoneyButton(_ sender: addRoundingButton)
    {
//        pd.removeFromSuperview()

        if let om = Bundle.main.loadNibNamed("OrangeMoney", owner: self, options: nil)?.first as? OrangeMoney
        {
            let y = stackView.frame.origin.y
            om.frame.origin = CGPoint(x: 0, y: y + 70)
            om.layer.borderWidth = 0.8
            om.layer.borderColor = Colors.greyBorder?.cgColor
            om.layer.cornerRadius = 5
            om.delegate = self
            self.addSubview(om)
        }
        
        
        
        paydunyaButton.layer.borderColor = Colors.greyBorder?.cgColor
        visaButton.layer.borderColor = Colors.greyBorder?.cgColor
        wariButton.layer.borderColor = Colors.greyBorder?.cgColor
        omoneyButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
    }
    
    
    @IBAction func wariButton(_ sender: addRoundingButton)
    {
        if let wari = Bundle.main.loadNibNamed("Wari", owner: self, options: nil)?.first as? Wari
        {
            let y = stackView.frame.origin.y
            wari.frame.origin = CGPoint(x: 0, y: y + 70)
            wari.layer.borderWidth = 0.8
            wari.layer.borderColor = Colors.greyBorder?.cgColor
            wari.layer.cornerRadius = 5
            wari.delegate = self
            self.addSubview(wari)
        }
        
        paydunyaButton.layer.borderColor = Colors.greyBorder?.cgColor
        visaButton.layer.borderColor = Colors.greyBorder?.cgColor
        wariButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
        omoneyButton.layer.borderColor = Colors.greyBorder?.cgColor
    }
    
    @IBAction func wizallButton(_ sender: addRoundingButton)
    {
//        pd.removeFromSuperview()

        if let wizall = Bundle.main.loadNibNamed("WizAll", owner: self, options: nil)?.first as? WizAll
        {
            let y = stackView.frame.origin.y
            wizall.frame.origin = CGPoint(x: 0, y: y + 70)
            wizall.layer.borderWidth = 0.8
            wizall.layer.borderColor = Colors.greyBorder?.cgColor
            wizall.layer.cornerRadius = 5
            wizall.delegate = self
            self.addSubview(wizall)
        }
        
        
        
        paydunyaButton.layer.borderColor = Colors.greyBorder?.cgColor
        visaButton.layer.borderColor = Colors.greyBorder?.cgColor
        wariButton.layer.borderColor = Colors.greyBorder?.cgColor
        omoneyButton.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
        
    }
    
    //MARK: Properties
    
    var pdunya = PayDunya()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    
}

extension Senegal: PayDunyaDelegate, WariDelegate
{
    
    
    func paymentWithPD(tel: String, code: String)
    {
        print("Voici est données de connexion pour PD: \(tel) et \(code)")
    }
    
//    func paymentWithVisa(tel: String)
//    {
//        print("Voici est données de connexion pour Visa: \(tel)")
//    }
    
    func paymentWithWari(tel: String)
    {
        print("Voici est données de connexion pour Wari: \(tel)")
    }
}
