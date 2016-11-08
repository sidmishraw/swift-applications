//
//  Time.swift
//  console
//
//  Created by Sidharth Mishra on 11/3/16.
//  Copyright © 2016 Sidharth Mishra. All rights reserved.
//

import Foundation
import Darwin

public class Time:Comparable {

    private var year:Int
    private var month:Int
    private var day:Int
    private var hour:Int
    private var minute:Int

    public var yearValue:Int {
        return self.year
    }
    
    public var monthValue:Int {
        return self.month
    }

    public var dayValue:Int {
        return self.day
    }

    public var hourValue:Int {
        return self.hour
    }

    public var minuteValue:Int {
        return self.minute
    }
 
    /// used for conformance to Hashable and Equatable
    /// protocols that are conformed by Comparable protocol
    private var hashcode:Int {

        return year.hashValue ^ month.hashValue + hour.hashValue
    }

    init(_ year:Int, _ month:Int, _ day:Int, _ hour:Int, _ minute:Int ) {

        self.year   = year
        self.month  = month
        self.day    = day
        self.hour   = hour
        self.minute = minute
    }

    /// Returns a Boolean value when lhs is equal to rhs
    /// used for conforming to Equatable protocol
    public static func ==(lhs:Time, rhs:Time) -> Bool {

        return lhs.year == rhs.year &&
            lhs.month == rhs.month &&
            lhs.day == rhs.day &&
            lhs.hour == rhs.hour &&
            lhs.minute == rhs.minute
    }

    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func <(lhs: Time, rhs: Time) -> Bool {

        if lhs == rhs {
            return false
        }

        switch((lhs,rhs)) {
        case let (x,y) where x.year > y.year: return false
        case let (x,y) where x.year == y.year
            && x.month > y.month: return false
        case let (x,y) where x.year == y.year
            && x.month == y.month
            && x.day > y.day: return false
        case let (x,y) where x.year == y.year
            && x.month == y.month
            && x.day > y.day: return false
        case let (x,y) where x.year == y.year
            && x.month == y.month
            && x.day == y.day
            && x.hour > y.hour: return false
        case let (x,y) where x.year == y.year
            && x.month == y.month
            && x.day == y.day
            && x.hour == y.hour
            && x.minute > y.minute: return false
        default: return true
        }
    }

    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than or equal to that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func <=(lhs: Time, rhs: Time) -> Bool {

        if lhs == rhs {
            return true
        } else {
            return lhs < rhs
        }
    }
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is greater than or equal to that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func >=(lhs: Time, rhs: Time) -> Bool {
        
        if lhs == rhs {
            return true
        } else {
            return lhs > rhs
        }
    }
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is greater than that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func >(lhs: Time, rhs: Time) -> Bool {

        if lhs == rhs {
            return false
        } else {

            return !(lhs < rhs)
        }
    }
}
