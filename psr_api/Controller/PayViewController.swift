//
//  PayViewController.swift
//  psr_api
//
//  Created by Mouhamed Camara on 7/6/20.
//  Copyright © 2020 PayDunya. All rights reserved.
//

import UIKit
import EzPopup
import SKCountryPicker
import EasyTipView




class PayViewController: UIViewController, EasyTipViewDelegate
{
    
    //MARK: Actions
    
    @IBAction func tipButtonTapped(_ sender: UIButton)
    {
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 12)!
        preferences.drawing.foregroundColor = .white //UIColor.whiteColor()
        preferences.drawing.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.4392156863, blue: 0.6980392157, alpha: 1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom

        preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = 1.5
        preferences.animating.dismissDuration = 1.5
        /*
         * Optionally you can make these preferences global for all future EasyTipViews
         */
        EasyTipView.globalPreferences = preferences
        
        EasyTipView.show(
            forView: self.tipButton,
            withinSuperview: self.view,
            text: "Paiements sécurisés de bout en bout par le programme PayDunya Secure",
            preferences: preferences,
            
            delegate: self
        )
    }
    
    func easyTipViewDidDismiss(_ tipView: EasyTipView)
    {
        print("Cacher")
    }
    
    static func instantiate() -> ViewController?
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(ViewController.self)") as? ViewController
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var tipButton: UIButton!
        
    @IBOutlet weak var stateChoiceView: UIView!
    
    @IBOutlet weak var stateFlag: UIImageView!
    
    @IBOutlet weak var stateChoice: UILabel!
    
    @IBOutlet weak var payWithLabel: UILabel!
    
    //MARK: Properties
    
//    let SNVC = SenegalViewController.instantiate()
    
    let pickerVC = StatePickerViewController.instantiate()

    var tapGesture = UITapGestureRecognizer()
    
    var dataSources = [Country]()
                
    var theState: Country!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        setup()
    }

    //MARK: Private Functions
    
    
    private func setup()
    {
        stateChoiceView.layer.cornerRadius = 5
        stateChoiceView.layer.borderWidth = 1
        stateChoiceView.layer.borderColor = Colors.greyBorder?.cgColor
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(open))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        stateChoiceView.addGestureRecognizer(tapGesture)
        stateChoiceView.isUserInteractionEnabled = true
        
        let country = CountryManager.shared.country(withCode: "SN")
        //        let country = CountryManager.shared.country(withName: "Ivoiry Coast")
        print("voici le \(country?.countryName ?? "")")
        stateFlag.image = country?.flag!
        stateChoice.text = country?.countryName
//                theState = country
        // Do any additional setup after loading the view.
        
        let senegal = CountryManager.shared.country(withCode: "SN")
        let civoire = CountryManager.shared.country(withCode: "CI")
        let benin = CountryManager.shared.country(withCode: "BJ")
        
        dataSources.append(senegal!)
        dataSources.append(civoire!)
        dataSources.append(benin!)
        
        if let senegal = Bundle.main.loadNibNamed("Senegal", owner: self, options: nil)?.first as? Senegal
        {
            senegal.frame.origin = CGPoint(x: 20, y: 100)
            self.view.addSubview(senegal)
        }
    }

}

extension ViewController: StatePickerViewControllerDelegate
{
    func statePickerViewController(sender: StatePickerViewController, didSelectNumber number: Int)
    {
        dismiss(animated: true)
        {
            if number != 0
            {
                let state = self.dataSources[number - 1]
                self.stateChoice.text = state.countryName
                self.stateFlag.image = state.flag!
                self.theState = state

                if number == 1
                {
                    if let senegal = Bundle.main.loadNibNamed("Senegal", owner: self, options: nil)?.first as? Senegal
                    {
                        senegal.frame.origin = CGPoint(x: 20, y: 100)
                        self.view.addSubview(senegal)
                    }
                }
                else if number == 2
                {
                    if let senegal = Bundle.main.loadNibNamed("CIvoire", owner: self, options: nil)?.first as? CIvoire
                    {
                        senegal.frame.origin = CGPoint(x: 20, y: 100)
                        self.view.addSubview(senegal)
                    }
                }
                else if number == 3
                {
                    if let senegal = Bundle.main.loadNibNamed("Benin", owner: self, options: nil)?.first as? Benin
                    {
                        senegal.frame.origin = CGPoint(x: 20, y: 100)
                        self.view.addSubview(senegal)
                    }
                }
                
            }
            else
            {
                
            }
        }
    }
    
    @objc func open()
    {
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            
            guard let pickerVC = self.pickerVC else { return }
            
            pickerVC.delegate = self
            let popupVC = PopupViewController(contentController: pickerVC, position: .top(self.stateChoiceView.frame.origin.y + self.stateChoiceView.frame.height + 10), popupWidth: self.stateChoiceView.frame.width, popupHeight: 200)
            popupVC.backgroundAlpha = 0.3
            popupVC.backgroundColor = .black
            popupVC.canTapOutsideToDismiss = true
            popupVC.cornerRadius = 10
            popupVC.shadowEnabled = true
            self.present(popupVC, animated: true, completion: nil)
//            self.containerView.isHidden = false
        }, completion: nil)
    }
}
