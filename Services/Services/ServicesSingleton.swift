//
//  ServicesSingleton.swift
//  Services
//
//  Created by MXMACMINI1 on 07/08/18.
//  Copyright © 2018 MB. All rights reserved.
//

import UIKit
import SystemConfiguration
class ServicesSingleton: NSObject {
   static let shared = ServicesSingleton()
    
    override init() {
    }
    
    func GETResults<Element: Decodable>(extraParam : String,targetView:UIViewController,myStruct: Element.Type, onTaskCompleted : @escaping (Decodable)->(Void) ) {
        let views = targetView as? AppsTVC
         guard let url = URL(string:extraParam) else{return}
        
        print(url)
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                if error?._code == NSURLErrorTimedOut {
                    views?.progrs.stopAnimating()
                    let alert = UIAlertController(title: "Please check your internet connection and try again After Sometime", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                    views?.present(alert, animated: true, completion: nil)
                }
            } else {
                guard let dataIs = data else { return }
                
                do {
                    let res = try JSONDecoder().decode(myStruct.self, from: dataIs)
                    onTaskCompleted(res)
                }catch {
                    print(error)
                    let alert = UIAlertController(title: "Unable to Process Your Request", message: "", preferredStyle: UIAlertController.Style.alert)
                    views?.progrs.stopAnimating()
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                    views?.present(alert, animated: true, completion: nil)
                }
            }
            
            }.resume()
    }
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
