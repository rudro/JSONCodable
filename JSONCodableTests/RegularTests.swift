//
//  RegularTests.swift
//  JSONCodable
//
//  Created by Matthew Cheok on 13/10/15.
//
//

import XCTest

class RegularTests: XCTestCase {
    
    let encodedValue = [
        "id": 24,
        "full_name": "John Appleseed",
        "email": "john@appleseed.com",
        "company": [
            "name": "Apple",
            "address": "1 Infinite Loop, Cupertino, CA"
        ],
        "friends": [
            ["id": 27, "full_name": "Bob Jefferson"],
            ["id": 29, "full_name": "Jen Jackson"]
        ],
        "friendsLookup": ["Bob Jefferson": ["id": 27, "full_name": "Bob Jefferson"]],
        "friendsArrayLookup": ["Bob Jefferson": [["id": 27, "full_name": "First Buddy"], ["id": 42, "full_name": "Second Buddy"]]]
    ]
    let decodedValue = User(
        id: 24,
        name: "John Appleseed",
        email: "john@appleseed.com",
        company: Company(name: "Apple", address: "1 Infinite Loop, Cupertino, CA"),
        friends: [
            User(id: 27, name: "Bob Jefferson", email: nil, company: nil, friends: [], friendsLookup: nil, friendsArrayLookup: nil),
            User(id: 29, name: "Jen Jackson", email: nil, company: nil, friends: [], friendsLookup: nil, friendsArrayLookup: nil)
        ],
        friendsLookup: ["Bob Jefferson":  User(id: 27, name: "Bob Jefferson", email: nil, company: nil, friends: [], friendsLookup: nil, friendsArrayLookup: nil)],
        friendsArrayLookup: ["Bob Jefferson":  [User(id: 27, name: "First Buddy", email: nil, company: nil, friends: [], friendsLookup: nil, friendsArrayLookup: nil), User(id: 42, name: "Second Buddy", email: nil, company: nil, friends: [], friendsLookup: nil, friendsArrayLookup: nil)]]     )

    func testDecodingRegular() {
        guard let user = try? User(object: encodedValue) else {
            XCTFail()
            return
        }

        XCTAssertEqual(user, decodedValue)
    }
  
    func testEncodingRegular() {
        guard let json = try? decodedValue.toJSON() else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(json as! [String : NSObject], encodedValue)
    }
}
