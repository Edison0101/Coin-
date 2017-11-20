//
//  FavoritetController.swift
//  Coin Tracker
//
//  Created by Rinor Bytyci on 11/13/17.
//  Copyright © 2017 Appbites. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage

//Klasa permbane tabele kshtuqe duhet te kete
//edhe protocolet per tabela
class FavoritetController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var teGjitha : [CoinCellModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teGjitha.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell") as! CoinCell
        
        cell.lblEmri.text = teGjitha[indexPath.row].coinName
        cell.lblTotali.text = teGjitha[indexPath.row].totalSuppy
        cell.lblAlgoritmi.text = teGjitha[indexPath.row].coinAlgo
        cell.lblSymboli.text = teGjitha[indexPath.row].coinSymbol
        cell.imgFotoja.af_setImage(withURL: URL(string:teGjitha[indexPath.row].coinImage())!)
        
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "coinCell")
        //Lexo nga CoreData te dhenat dhe ruaj me nje varg
        //qe duhet deklaruar mbi funksionin UIViewController
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let rezultati = try context.fetch(request)
            for elementi in rezultati as! [NSManagedObject]{
                
                let coin = CoinCellModel(coinName: elementi.value(forKey: "coinName") as! String, coinSymbol: elementi.value(forKey: "coinSymbol") as! String, coinAlgo: elementi.value(forKey: "coinAlgo") as! String, totalSuppy: elementi.value(forKey: "totalSupply") as! String, imagePath: elementi.value(forKey: "imagePath") as! String)
          
                
                teGjitha.append(coin)
                
            }
            tableView.reloadData()
            
        } catch {
            print("Gabim gjate Leximit")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mbyllu(_ sender: Any) {
     self.dismiss(animated: true, completion: nil)
    }
    
}
