//
//  ViewController.swift
//  MXAtrium
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var transactionsTableView: UITableView!
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var transactionsJSON: JSON = JSON.null
    var transactionsCount = 0
    
    let baseURL = "https://vestibule.mx.com/users/USR-xxxxx/" // Append User id
    let headers = [
        "Accept": "application/vnd.mx.atrium.v1+json",
        "MX-API-KEY": "xxxxx", // Replace with Atrium API key
        "MX-CLIENT-ID": "xxxxx" // Replace with Atrium client-id
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        getTransactions()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionsItem", for: indexPath)
        
        // title
        let name = cell.viewWithTag(1000) as! UILabel
        name.text = transactionsJSON["transactions", indexPath.row, "description"].string
        
        // category
        let category = cell.viewWithTag(2000) as! UILabel
        category.text = transactionsJSON["transactions", indexPath.row, "top_level_category"].string
        
        // date
        let date = cell.viewWithTag(3000) as! UILabel
        var dateTemp: String! = transactionsJSON["transactions", indexPath.row, "transacted_at"].string
        let indexTo = dateTemp.index(dateTemp.startIndex, offsetBy: 10)
        dateTemp = dateTemp.substring(to: indexTo)
        date.text = dateTemp
        
        // amount
        let amount = cell.viewWithTag(4000) as! UILabel
        amount.text = "$" + transactionsJSON["transactions", indexPath.row, "amount"].stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getTransactions() {
        
        activityIndicator()
        
        Alamofire.request("\(baseURL)transactions", method: .get, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print (error)
                    print ("Error calling API: \(error)\n\n")
                    return
                case .success:
                    
                    if let value = response.result.value {
     
                        // store the JSON repsonse
                        self.transactionsJSON = JSON(value)
                        
                        // print JSON response to console for debug purposes
                        print("JSON: \(self.transactionsJSON)")
                        
                        // count transaction rows using SwiftyJSON and print to debug console
                        for (key,subJson):(String, JSON) in self.transactionsJSON["transactions"] {
                            print("\(key) \(subJson["description"]) \(subJson["amount"]) \(subJson["transacted_at"]) \(subJson["top_level_category"])")
                            self.transactionsCount += 1
                        }
                        
                        // reload tableview
                        self.transactionsTableView.reloadData()
                        
                        // stop activityIndicator
                        self.indicator.stopAnimating()
                        self.indicator.hidesWhenStopped = true
                        
                    } // if
                    
                } // switch
                
        } // Alamofire
        
    } // getTransactions()
    
    func activityIndicator() {
        indicator.color = UIColor .white
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0)
        let indicatorPosition = CGPoint(x: self.view.frame.size.width / 2, y: 380)
        indicator.center = indicatorPosition
        self.view.addSubview(indicator)
        indicator.bringSubview(toFront: self.view)
        indicator.startAnimating()
    }
    
}

