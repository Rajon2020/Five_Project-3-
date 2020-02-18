//
//  ViewController.swift
//  Raj_apiimage
//
//  Created by apple on 2/17/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var imageName = [String]()
   var modelData = [MyModel]()
    
    

    func loadData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do{
                    let myData = try! JSONDecoder().decode([MyModel].self, from: data!)
                    DispatchQueue.main.async {
                        for n in myData{
                            
                            self.imageName.append(n.url)
                        }
                        
                        self.tableview.reloadData()
                    }
                }catch{
                    print("nothing")
                }
                
            }
            
        }.resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
                let url = URL(string: imageName[indexPath.row])
                       DispatchQueue.global().async {
                           //let data = try?Data(contentsOf: url!)
                           DispatchQueue.main.async {
                               //withAlamofireImageloadingWithurl;
                               cell.cellImage.af_setImage(withURL: url!)
                               
                               //cell.cellImageView.image = UIImage(data: data!)
                           }
                           
                       }
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }


}

