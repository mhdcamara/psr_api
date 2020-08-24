//
//  MainViewController.swift
//  psr_api
//
//  Created by Mouhamed Camara on 7/6/20.
//  Copyright © 2020 PayDunya. All rights reserved.
//

import UIKit
import EzPopup
import Alamofire
import SwiftyJSON



class MainViewController: UIViewController
{

    let VC = ViewController.instantiate()

    @IBAction func showFullCustomPopupButtonTapped(_ sender: Any) {
        guard let pickerVC = VC else { return }
        
//        pickerVC.delegate = self
        
        
        let popupVC = PopupViewController(contentController: pickerVC, position: .top(50), popupWidth: self.view.frame.width - 20, popupHeight: self.view.frame.height - 70)
        popupVC.backgroundAlpha = 0.3
        popupVC.backgroundColor = .black
        popupVC.canTapOutsideToDismiss = true
        popupVC.cornerRadius = 10
        popupVC.shadowEnabled = true
        present(popupVC, animated: true, completion: nil)
        
        CheckoutInvoice()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //MARK: Privates Function
    
    private func CheckoutInvoice()
    {
        /*
          *   Préparation de la requete
          */
         
         
         // Initialisation des paramétres de la requete
        let Store = PaydunyaStore(
             name: "paydunyaIOS-Plugin",
             tagline: "L'élégance c'est nous!",
             postal_address: "11500",
             phone: 778064927,
             logo_url: "",
             website_url: ""
         )
         
         Store.total_amount = 200
         Store.description = "Chaussures Croco"
         
         Store.items = [
                 "name": "Chaussures Croco",
                 "quantity": 3,
                 "unit_price": "10000",
                 "total_price": "30000",
                 "description": "Chaussures faites en peau de crocrodile authentique qui chasse la pauvreté"
         ]
         
         Store.taxes = [
                 "name": "TVA (18%)",
                 "amount": 12
         ]
        
         //Initialisation des Clé d'API
         let Setup = PaydunyaSetup(
            MasterKey: AppConstant.master_key,
            PrivateKey: AppConstant.private_key,
            Token: AppConstant.token,
            cancel_url: AppConstant.cancel_url,
            return_url:  AppConstant.return_url,
            callback_url: AppConstant.callback_url
         )
         
         let invoice = PaydunyaInvoice()
         
         let Headers: HTTPHeaders = Setup.setup()
        
         let Parametres: Parameters = invoice.Invoice(store: Store, setup: Setup)
        
         // La requete avec Alamofire
         
         Alamofire.request("https://app.paydunya.com/api/v1/checkout-invoice/create", method: .post ,parameters: Parametres, encoding: JSONEncoding.default, headers: Headers).responseJSON
         {
             response in
             print("ResultJSON: \(response.result)")    // On affiche la réponse en JSON
             
             
             // On regarde la réponse renvoyée par la requete
             switch response.result
             {
                 case let .success(value): // En cas de Succes de la requete
                     
                     let json = JSON(value)
                     
                     print("Voici la réponse: \(json)")
                     
                     let urlpaiement = json["response_text"].stringValue
                     
                     AppConstant.payment_url = urlpaiement
                     
                     //On redirige l'utilisateur vers la page de paiement
                     
                     let token = json["token"].stringValue
                     
                     print("Le token: \(token)")
                     print("L'url: \(urlpaiement)")
                
                     AppConstant.invoice_token = token
                 
                 case let .failure(error): print(error)
             }
          
         }
    }
}
