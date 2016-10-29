//
//  main.swift
//  console
//
//  Created by Sidharth Mishra on 10/22/16.
//  Copyright © 2016 Sidharth Mishra. All rights reserved.
//

import Foundation
import CoreText

// stripping newLine = true by default
// removes the \n character from the line read from console via standard input
// for eg - huuu
// Optional("huuu")
// marking it false will make it stay after line is read 
// for eg - huuu
// Optional("huuu\n")
// var L = readLine(strippingNewline: true)

// Pp is a singleton class -- made using the same style as in Java
// since swift is a Object-Oriented Language, it is possible to achieve
// the same styled design patterns as in Java
// I like this shit better than Java.. gotta understand swift better than I understood Java
// when it is still young
// new language for new people
// start a-new
public class Pp {
  
    // daisy is a stored-property --- instance attribute that actually stores values inside it
    private var daisy :Double?

    // accessDaisy is a computed property/attibute, it doesn't store values
    // instead it is used to compute values to be stored in stored property
    // like daisy, it has get-set properties
    // these are used to work on the private daisy "stored-property"
    // now in this case, 
    // get - set have a different meaning in swift
    // getter-setter syntax is a bit different in swift than other languages xD
    // I find this more productive, since the getter and setter are defined just near the actual
    // stored variable
    public var accessDaisy:Double {

        get {

            print("getting")
            if let x = self.daisy {
                return x
            } else {
                return 0.0
            }
        }

        set(x) {

            print("setting")
            self.daisy = x
        }
    }

    private static var pp:Pp? = nil

    private init() {}

    public static func getInstance() -> Pp? {

        if nil == pp {

            pp = Pp()
        }

        return pp
    }

    public func setDaisy(_ daisy:Double) {
        self.daisy = daisy
    }
    
    public func getDaisy() -> Double? {

        return self.daisy
    }
}


///////////////////////// -- running implementation

//guard var x = Pp.getInstance(), var y = Pp.getInstance() else {
//
//    exit(0)
//}
//
//x.setDaisy(10.0)
//x.accessDaisy = 20.0
//print(x.accessDaisy)
//
//print(x===y)
// diagonalDiff()
// plusMinus()
// kangaroo()
// viralAdvertising()

// using file handle to read data from files
//let f:FileHandle = FileHandle.init(forReadingAtPath: "/Users/sidmishraw/Documents/iosstuff/abc.txt")!
//
//var x = f.readDataToEndOfFile()
//
//// using NSString tp convert data(bytes) to string format
//var i = NSString.init(data: x, encoding: String.Encoding.utf8.rawValue)
//
//// using String init to read data directly from file as string

var xx:String?
var xxE = String.Encoding.utf32
do {

    //xx = try? String(contentsOfFile:"/Users/sidmishraw/Documents/iosstuff/abc.txt", usedEncoding: &xxE)
    xx = try? String(contentsOfFile:"/Users/sidmishraw/Documents/iosstuff/abc.txt")
}

var ipxx:[[Int]] = []
var ipx = (xx!.characters.split(separator: "\n").map({String($0)})).map({
    (x:String) in
    ipxx.append(x.characters.split(separator: " ").map({
        (y:String.CharacterView) -> Int in
        return Int(String(y))!
    }))
})



bfsShortestReach(ipxx)
