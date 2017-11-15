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
import AlamofireImage
//Duhet te jete conform protocoleve per tabele
class ListaController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    //URL per API qe ka listen me te gjithe coins
    //per me shume detaje : https://www.cryptocompare.com/api/
    let APIURL = "https://min-api.cryptocompare.com/data/all/coinlist"
   
    var slectedCoin:CoinCellModel!
    //Krijo nje varg qe mban te dhena te tipit CoinCellModel
     var allCoins : [CoinCellModel] = []
    //kjo perdoret per tja derguar Controllerit "DetailsController"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "shfaqDetajet"{
            
            let AnyDetailsController = segue.destination as! DetailsController
            
          AnyDetailsController.selectedCoin = slectedCoin
        }
        
        }
        
      func merrCoin(){
        
        Alamofire.request(APIURL).responseData { (data) in
            
             if data.result.isSuccess{
                
                let coincellmodelJSON = try! JSON(data: data.result.value!)
                
                for(_, value) : (String, JSON) in coincellmodelJSON["Data"]{
                    
                    let coinCellmodel = CoinCellModel (coinName: value ["CoinName"].stringValue, coinSymbol: value["Name"].stringValue, coinAlgo: value["Algorithm"].stringValue, totalSuppy: value["TotalCoinSupply"].stringValue, imagePath: value["ImageUrl"].stringValue)
                    self.allCoins.append(coinCellmodel)
                
                }
                self.tableView.reloadData()
                
                
                

                
               //tableView.reloadData()
            }
            }
       
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       tableView.register(UINib.init(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "coinCell")
        //reuse identifier
        merrCoin()
    }
    
    
    //Funksioni getDataFromAPI()
    //Perdor alamofire per te thirre APIURL dhe ruan te dhenat
    //ne listen vargun me CoinCellModel
    //Si perfundim, thrret tableView.reloadData()
    func getDataFromAPI(){
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell") as! CoinCell
        cell.lblEmri.text = allCoins[indexPath.row].coinName
        cell.lblAlgoritmi.text = allCoins[indexPath.row].coinAlgo
        cell.lblSymboli.text = allCoins[indexPath.row].coinSymbol
        cell.lblTotali.text = allCoins[indexPath.row].totalSuppy
        cell.imgFotoja.af_setImage(withURL: URL(string: allCoins[indexPath.row].imagePath)!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return allCoins.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let coin = allCoins[indexPath.row]
        slectedCoin = coin
        
        performSegue(withIdentifier: "shfaqDetajet", sender: self )
    }
    //Funksioni didSelectRowAt indexPath merr parane qe eshte klikuar
    //Ruaj Coinin e klikuar tek selectedCoin variabla e deklarurar ne fillim
    //dhe e hap screenin tjeter duke perdore funksionin
    //performSeguew(withIdentifier: "EmriILidhjes", sender, self)
    
    
    //Beje override funksionin prepare(for segue...)
    //nese identifier eshte emri i lidhjes ne Storyboard.
    //controllerit tjeter ja vendosim si selectedCoin, coinin
    //qe e kemi ruajtur me siper

   

}

