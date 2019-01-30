//
//  AppsTVC.swift
//  Services
//
//  Created by MXMACMINI1 on 07/08/18.
//  Copyright © 2018 MB. All rights reserved.
//

import UIKit
import Kingfisher
class AppsTVC: UITableViewController {
    var appData:Students?
    @IBOutlet weak var progrs: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsing()
        self.tableView.backgroundView = progrs
        self.tableView.tableFooterView = UIView()
    }
    func jsonParsing() {
        progrs.startAnimating()
        if ServicesSingleton.shared.isConnectedToNetwork() {
            ServicesSingleton.shared.GETResults(extraParam: "https://randomuser.me/api/?exc=login&results=30",targetView:self,myStruct: Students.self) { (data) -> (Void) in
            self.appData = data as? Students
            DispatchQueue.main.async {
                self.progrs.stopAnimating()
                self.tableView.reloadData()
            }
        }
        }else {
           self.progrs.stopAnimating()
           let alert = UIAlertController(title: "No Internet Connection", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Open Settings", style: UIAlertAction.Style.default, handler: { (act) in
                if let url = URL(string:"App-Prefs:root=Settings&path=General") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: { (act1) in
                self.jsonParsing()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData?.results.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataParts = appData?.results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppsCell", for: indexPath) as! AppCell
        if indexPath.row%2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.4604515433, green: 0.5220510364, blue: 0.774520278, alpha: 1)
            cell.artistName.textColor = UIColor.white
            cell.releaseDate.textColor = UIColor.white
        }else {
            cell.backgroundColor = #colorLiteral(red: 0.781075716, green: 0.9392863512, blue: 0.7419781089, alpha: 1)
            cell.artistName.textColor = UIColor.black
            cell.releaseDate.textColor = UIColor.black
        }
        cell.artistName.text = "\(dataParts?.name.first ?? "") \(dataParts?.name.last ?? "")"
        cell.releaseDate.text = dataParts?.email
        cell.appImage.kf.setImage(with: URL(string: (dataParts?.picture?.medium)!))
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let dataParts = appData?.results[indexPath.row]
       let DetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentDetail") as! StudentDetail
      DetailsVC.detailsArray.append((images: dataParts?.picture?.large ?? "", first: dataParts?.name.first ?? "", last: dataParts?.name.last ?? "", street:dataParts?.location?.street ?? "", city:dataParts?.location?.city ?? "", email: dataParts?.email ?? "", phone: dataParts?.phone ?? "", cell: dataParts?.cell ?? ""))
      self.present(DetailsVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationAngleInRadians = 360.0 * CGFloat(.pi/360.0)
        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, -500, 100, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 1.0, animations: {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        })
    }
}
