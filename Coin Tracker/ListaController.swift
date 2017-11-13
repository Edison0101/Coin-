//
//  ListaController.swift
//  Coin Tracker
//
//  Created by Rinor Bytyci on 11/12/17.
//  Copyright © 2017 Appbites. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
//Duhet te jete conform protocoleve per tabele
class ListaController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   
    var slectedCoin:CoinCellModel!
    //Krijo nje varg qe mban te dhena te tipit CoinCellModel
     var allCoins : [ListaController] = []
    //kjo perdoret per tja derguar Controllerit "DetailsController"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "shfaqDetajet"{
            
            let AnyDetailsController = segue.destination as! DetailsController
            
            AnyDetailsController.selectedCoin = slectedCoin
        }
      func merrCoin(params:[String:String]){
        
        Alamofire.request(APIURL, method: .get, parameters: params).responseData { (data) in
            
             if data.result.isSuccess{
                
                 let coincellmodelJSON = try! JSON(data: data.result.value!)
                
                 let coinCellmodel = CoinCellModel (coinName: coincellmodelJSON ["name"], coinSymbol: <#T##String#>, coinAlgo: <#T##String#>, totalSuppy: <#T##String#>, imagePath: <#T##String#>)
            }
        }
        
    //URL per API qe ka listen me te gjithe coins
    //per me shume detaje : https://www.cryptocompare.com/api/
    let APIURL = "https://min-api.cryptocompare.com/data/all/coinlist"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //regjistro custom cell qe eshte krijuar me NIB name dhe
        //reuse identifier
        
        //Thirr funksionin getDataFromAPI()
    }
    
    //Funksioni getDataFromAPI()
    //Perdor alamofire per te thirre APIURL dhe ruan te dhenat
    //ne listen vargun me CoinCellModel
    //Si perfundim, thrret tableView.reloadData()
    func getDataFromAPI(){
        
    }

    //Shkruaj dy funksionet e tabeles ketu
    //cellforrowat indexpath dhe numberofrowsinsection
    
    
    //Funksioni didSelectRowAt indexPath merr parane qe eshte klikuar
    //Ruaj Coinin e klikuar tek selectedCoin variabla e deklarurar ne fillim
    //dhe e hap screenin tjeter duke perdore funksionin
    //performSeguew(withIdentifier: "EmriILidhjes", sender, self)
    
    
    //Beje override funksionin prepare(for segue...)
    //nese identifier eshte emri i lidhjes ne Storyboard.
    //controllerit tjeter ja vendosim si selectedCoin, coinin
    //qe e kemi ruajtur me siper

   

}
