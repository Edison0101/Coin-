//
//  ViewController.swift
//  Coin Tracker
//
//  Created by Rinor Bytyci on 11/12/17.
//  Copyright © 2017 Appbites. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import CoreData

class DetailsController: UIViewController {

    //selectedCoin deklaruar me poshte mbushet me te dhena nga
    //controlleri qe e thrret kete screen (Shiko ListaController.swift)
    var selectedCoin:CoinCellModel!
    
    
    //IBOutlsets jane deklaruar me poshte
    @IBOutlet weak var imgFotoja: UIImageView!
    @IBOutlet weak var lblDitaOpen: UILabel!
    @IBOutlet weak var lblDitaHigh: UILabel!
    @IBOutlet weak var lblDitaLow: UILabel!
    @IBOutlet weak var lbl24OreOpen: UILabel!
    @IBOutlet weak var lbl24OreHigh: UILabel!
    @IBOutlet weak var lbl24OreLow: UILabel!
    @IBOutlet weak var lblMarketCap: UILabel!
    @IBOutlet weak var lblCmimiBTC: UILabel!
    @IBOutlet weak var lblCmimiEUR: UILabel!
    @IBOutlet weak var lblCmimiUSD: UILabel!
    @IBOutlet weak var lblCoinName: UILabel!
    
    var appdelegate:AppDelegate!
    var context:NSManagedObjectContext!
    
    //APIURL per te marre te dhenat te detajume per coin
    //shiko: https://www.cryptocompare.com/api/ per detaje
    let APIURL = "https://min-api.cryptocompare.com/data/pricemultifull"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        imgFotoja.af_setImage(withURL: URL(string: selectedCoin.coinImage())!)
        lblCoinName.text = selectedCoin.coinName
       
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appdelegate.persistentContainer.viewContext
        
        
        //brenda ketij funksioni, vendosja foton imgFotoja Outletit
        //duke perdorur AlamoFireImage dhe funksionin:
        //af_setImage(withURL:URL)
        //psh: imgFotoja.af_setImage(withURL: URL(string: selectedCoin.imagePath)!)
        //Te dhenat gjenerale per coin te mirren nga objeti selectedCoin
        
        let params : [String: String] = ["fsyms" : selectedCoin.coinSymbol, "tsyms" : "BTC,USD,EUR"]
        //Krijo nje dictionary params[String:String] per ta thirrur API-ne
        //parametrat qe duhet te jene ne kete params:
        //fsyms - Simboli i Coinit (merre nga selectedCoin.coinSymbol)
        //tsyms - llojet e parave qe na duhen: ""BTC,USD,EUR""
        
        getDetails(params: params)
        //Thirr funksionin getDetails me parametrat me siper
    }

    func getDetails(params:[String:String]){
        
        Alamofire.request(APIURL, method: .get, parameters: params).responseData { (data) in
            
            if data.result.isSuccess{
                
                let coindetailmodel = try! JSON(data: data.result.value!)
                
                let coindetail = CoinDetailsModel (marketCap: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["MKTCAP"].stringValue,
                                                   hourHigh: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["HIGH24HOUR"].stringValue,
                                                   hourLow: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["LOW24HOUR"].stringValue,
                                                   hourOpen: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["MKTCAP"].stringValue,
                                                   dayHigh: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["OPENDAY"].stringValue,
                                                   dayLow: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["LOWDAY"].stringValue,
                                                   dayOpen: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["OPENDAY"].stringValue,
                                                   priceEUR: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["EUR"]["PRICE"].stringValue,
                                                   priceUSD: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["USD"]["PRICE"].stringValue,
                                                   priceBTC: coindetailmodel["DISPLAY"][self.selectedCoin.coinSymbol]["BTC"]["PRICE"].stringValue)
                self.updateUI(coin: coindetail)
            }
            
            
        }
        //Thrret Alamofire me parametrat qe i jan jap funksionit
        //dhe te dhenat qe kthehen nga API te mbushin labelat
        //dhe pjeset tjera te view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(coin:CoinDetailsModel){
        lblDitaHigh.text = coin.dayHigh
        lblCmimiEUR.text = coin.priceEUR
        lblDitaLow.text = coin.dayLow
        lbl24OreLow.text = coin.hourLow
        lblDitaOpen.text = coin.dayOpen
        lblCmimiBTC.text = coin.priceBTC
        lblCmimiUSD.text = coin.priceUSD
        lblMarketCap.text = coin.marketCap
        lbl24OreHigh.text = coin.hourHigh
        lbl24OreOpen.text = coin.hourOpen
    }
    
    
    @IBAction func mbylle(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    }
    
  
    
    
    @IBAction func Ruaj(_ sender: Any) {
    
    let teDhenat = NSEntityDescription.insertNewObject(forEntityName: "Users", into: self.context)
    
        teDhenat.setValue(String(selectedCoin.imagePath), forKey: "imagePath")
        teDhenat.setValue(String(selectedCoin.coinSymbol), forKey: "coinSymbol")
        teDhenat.setValue(String(selectedCoin.coinAlgo), forKey: "coinAlgo")
        teDhenat.setValue(String(selectedCoin.coinName), forKey: "coinName")
        teDhenat.setValue(String(selectedCoin.totalSuppy), forKey: "totalSupply")
        
        print(teDhenat)
    
        do {
            try self.context.save()
            print("OK")
        } catch {
            print("Gabim gjate ruajtjes")
        }

    
    }
}
