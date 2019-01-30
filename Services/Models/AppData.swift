//
//  File.swift
//  Services
//
//  Created by MXMACMINI1 on 07/08/18.
//  Copyright © 2018 MB. All rights reserved.
//


import Foundation
struct Students :Decodable {
    let results:[ResultsData]
    let info:InfoData
}
struct ResultsData :Decodable {
    let gender:String
    let name:StudentName
    let location:StudentLocation?
    let email:String
    let dob:StudentDOB?
    let phone:String
    let cell:String
    let picture:StudentImages?
}
struct StudentName : Decodable {
    let title:String
    let first:String
    let last:String
}
struct StudentLocation : Decodable {
    let street:String
    let city:String
    let state:String
   // let postcode : Int?
}
struct StudentDOB : Decodable {
    let date:String
    let age:Int
}
struct StudentImages : Decodable {
    let large:String
    let medium:String
    let thumbnail:String
}
struct InfoData : Decodable {
    let seed:String
    let results:Int
    let page:Int
    let version:String
}

