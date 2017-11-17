//
//  FavoritetController.swift
//  Coin Tracker
//
//  Created by Rinor Bytyci on 11/13/17.
//  Copyright © 2017 Appbites. All rights reserved.
//

import UIKit

//Klasa permbane tabele kshtuqe duhet te kete
//edhe protocolet per tabela
class FavoritetController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Lexo nga CoreData te dhenat dhe ruaj me nje varg
        //qe duhet deklaruar mbi funksionin UIViewController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
