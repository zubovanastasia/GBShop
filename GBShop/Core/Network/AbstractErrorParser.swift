//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 24.03.2022.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
