//
//  MessageRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Alamofire
import Foundation

func TestRequest() {
    AF.request("https://httpbin.org/get").response { response in
        debugPrint(response);
    }
}
