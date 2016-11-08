//
//  hackerrankExercises.swift
//  console
//
//  Created by Sidharth Mishra on 10/24/16.
//  Copyright © 2016 Sidharth Mishra. All rights reserved.
//

import Foundation
import Darwin

/// START - Dijkstra: Shortest Reach 2
/// difficulty - hard
/// Dijkstra: Shortest Reach 2
/// swift 2.2 on hackerrank website
/// swift 3.0 version
/// use my algo modifying it to react to variable distances and not 6
/// Note - cannot use internal or other access specifiers within local scopes i.e
/// inside functions/methods or closures
/// cannot conform to Hashable or Equatable protocols when the class is within some local scope
/// this is because we need to define the == method for the class inorder to conform to the Equatable protocol
/// and since Swift define's it's version in global scope, the func for the conformant class too has to be globally
/// accessible. Hence need to define the class in global scope, outside all functions/methods.
/// Need to review this concept!
public class Edge:Hashable {

    public var e1:Int
    public var e2:Int

    public var hashValue: Int {

        return e1.hashValue ^ e2.hashValue
    }

    init(_ x:Int,_ y:Int) {
        e1 = x
        e2 = y
    }

    public static func ==(lhs: Edge, rhs: Edge) -> Bool {

        return
            (lhs.e1 == rhs.e1 &&
                lhs.e2 == rhs.e2) || (lhs.e1 == rhs.e2 &&
                    lhs.e2 == rhs.e1)
    }
}

// distance map
public class DistMap2 {

    var dmap:[Int]?
    var vertices:CountableClosedRange<Int>
    // edge and it's corressponding weight
    var edges:[Edge:Int] = [:]
    // holds the adjacency matrix
    var edgelib:[Int:Set<Int>] = [:]
    var s:Int?
    var next:Set<Int> = []

    init(count:Int,repeatedValue:Int) {

        dmap = Array(repeating: repeatedValue, count: count)
        vertices = 1 ... count
    }

    public func setS(_ s:Int) {

        self.s = s
        dmap![s-1] = 0
    }
}

/// Again the time is being consumed while reading inputs
/// to optimize the IO time, I'm planning to read stuff into a set of Strings
/// then iterate over that set
public func dijkstraShortestReach(_ ipx:[[Int]]) {

    // gather inputs
    // nbr of runs
    // let t = Int(readLine(strippingNewline: true)!)!
    var ipx1 = 0

    let t = ipx[ipx1][0]

    // vertices ranges for each run
    var distMaps:[DistMap2] = []

    // gather inputs for each run
    for _ in 0 ..< t {

        ipx1 += 1

        // reading in metadata for the inputs - 0 - nbr of vertices 1 - nbr of edges
        // let ti = readLine(strippingNewline: true)!.characters.split(separator: " ").map{Int(String($0))!}
        let ti = ipx[ipx1]

        // reading in edges and their corressponding weights
        // [e1,e2,d]
        // let distMap hold all values needed for computation
        let distMap = DistMap2(count: ti[0], repeatedValue: -1)

        var edgeInputs:Set<String> = []

        // read all edges as string into a set, so as to eliminate the duplicate entries
        // to speed up the IO process
        // this will ensure that the duplicate entries are not needed to be split
//        for _ in 0 ..< ti[1] {
//
//            let ei = readLine(strippingNewline: true)!
//            edgeInputs.insert(ei)
//        }

        // read in each edge
//        for ipedge in edgeInputs {
        for _ in 0 ..< ti[1] {

            // let ei = readLine(strippingNewline: true)!.characters.split(separator: " ").map{Int(String($0))!}
            // let ei = ipedge.characters.split(separator: " ").map{Int(String($0))!}
            ipx1 += 1

            let ei = ipx[ipx1]

            // since edges are un-directed
            var edge1   = Edge(ei[0], ei[1])

            if distMap.edges[edge1] == nil
                || ei[2] < distMap.edges[edge1]! {

                distMap.edges[edge1] = ei[2]
            }
        }

        ipx1 += 1

        // reading start vertex for the run
        // let sv = Int(readLine(strippingNewline: true)!.trimmingCharacters(in: CharacterSet(charactersIn: " ")))!
        let sv = ipx[ipx1][0]

        distMap.setS(sv)

        distMaps.append(distMap)
    }

    // compute
    for i in 0 ..< t {

        // get the corressponding distMap
        var distMap = distMaps[i]

        // build edges lib for adjacency matrix
        for edge in distMap.edges {

            if distMap.edgelib[edge.key.e1] == nil {

               distMap.edgelib[edge.key.e1] = [edge.key.e2]
            } else {

               distMap.edgelib[edge.key.e1]!.insert(edge.key.e2)
            }

            if distMap.edgelib[edge.key.e2] == nil {

                distMap.edgelib[edge.key.e2] = [edge.key.e1]
            } else {

                distMap.edgelib[edge.key.e2]!.insert(edge.key.e1)
            }
        }

        // for the sake of completion
        // any vertex without edges has an empty set of edges along side it
        for v in distMap.vertices {

            if distMap.edgelib[v] == nil {

                distMap.edgelib[v] = []
            }
        }

        // approach v1.0
        func recursiveDistCalc2(_ distMap: DistMap2) {

            if distMap.next.isEmpty {

                return
            }

            _ = distMap.next.map {

                let vrtx = $0

                _ = distMap.edgelib[vrtx]!.map {

                    let adjvrtx = $0

                    let edge = Edge(vrtx,adjvrtx)

                    if distMap.dmap![adjvrtx - 1] == -1
                        || distMap.dmap![vrtx - 1] + distMap.edges[edge]! < distMap.dmap![adjvrtx - 1] {

                        distMap.dmap![adjvrtx - 1] = distMap.dmap![vrtx - 1] + distMap.edges[edge]!

                        // only insert those vertices if the edge is updated, else do nothing
                        distMap.next.insert(adjvrtx)
                    }
                }

                _ = distMap.next.remove(vrtx)
            }

//            for vrtx in distMap.next {
//
//                for adjvrtx in distMap.edgelib[vrtx]! {
//
//                    let edge = Edge(vrtx,adjvrtx)
//
//                    if distMap.dmap![adjvrtx - 1] == -1
//                        || distMap.dmap![vrtx - 1] + distMap.edges[edge]! < distMap.dmap![adjvrtx - 1] {
//
//                        distMap.dmap![adjvrtx - 1] = distMap.dmap![vrtx - 1] + distMap.edges[edge]!
//
//                        // only insert those vertices if the edge is updated, else do nothing
//                        distMap.next.insert(adjvrtx)
//                    }
//                }
//
//              _ = distMap.next.remove(vrtx)
//            }

            return recursiveDistCalc2(distMap)
        }

        distMap.next.insert(distMap.s!)

        recursiveDistCalc2(distMap)

        print(distMap.dmap!.reduce(" ") {

            if $1 == 0 {

                return $0 + ""
            } else {

                return $0 + "\(String($1)) "
            }
            }.trimmingCharacters(in: CharacterSet(charactersIn : " ")))
    }
}
/// END - Dijkstra: Shortest Reach 2

/// START - Breadth First Search: Shortest Reach
// difficulty - medium
// Breadth First Search: Shortest Reach
// swift 2.2 version on hackerrank website
// author - sidharth.mishra <sidmishraw>
// swift 3.0 version
// bruteforce
// recursion
// optimized :) problem was with the inputs xD
public func bfsShortestReach(_ ipx: [[Int]]) {

    //gather inputs
    //let q = Int(readLine(strippingNewline: true)!)!
    let q = ipx[0][0]

    // vertices array containing vertices from each run
    var verticesArr:[CountableClosedRange<Int>] = []
    // edges array containing edges from each run
    var edgesArr:[[(Int,Int)]] = []
    // start vertex array from each run
    var sArr:[Int] = []

    var ipx1 = 0

    // read inputs
    for _ in 1 ... q {

        ipx1 = ipx1 + 1

//        var secLine:[Int] = readLine(strippingNewline: true)!
//            .characters.split(separator: " ").map({Int(String($0))!})
        var secLine:[Int] = ipx[ipx1]

        // edges is an array of tuples
        var edges:[(Int,Int)] = []

        let vertices = 1...secLine[0]

        verticesArr.append(vertices)

        var edgeInputs:[Int] = []

        for _ in 1 ... secLine[1] {

            ipx1 = ipx1 + 1

//            edgeInputs      = readLine(strippingNewline: true)!
//                .characters.split(separator: " ").map({Int(String($0))!})

            edgeInputs        = ipx[ipx1]

//            if !edges.contains(where: { $0.0 == edgeInputs[0] && $0.1 == edgeInputs[1]} ) {

                edges.append((edgeInputs[0],edgeInputs[1]))
//            }
        }

        // add the edges from run into edgesArr
        edgesArr.append(edges)

        ipx1 = ipx1 + 1

//        let s:Int = Int(readLine(strippingNewline: true)!.trimmingCharacters(in: CharacterSet(charactersIn: " ")))!
        let s:Int = ipx[ipx1][0]

        // add the s from run into sArr
        sArr.append(s)
    }

    // distance map
    class DistMap {
        
        var map:[Int]?
        var edgelib:[Int:Set<Int>] = [:]
        var traversed:[Int:Bool] = [:]
        var s:Int?
        var next:Set<Int> = []
        
        init(count:Int,repeatedValue:Int, s:Int) {
            
            map = Array(repeating: repeatedValue, count: count)
            self.s = s
            map![s-1] = 0
        }
    }

    // compute
    for run in 0 ..< q {

        let distMap = DistMap(count:verticesArr[run].count,repeatedValue:-1, s:sArr[run])

        // create the edgelib - adjacency dictionary
        for (e1,e2) in edgesArr[run] {

            if distMap.edgelib[e1] == nil {

                distMap.edgelib[e1] = [e2]
            } else if (distMap.edgelib[e1]?.isEmpty)! {

                distMap.edgelib[e1]?.insert(e2)
            } else {

                distMap.edgelib[e1]?.insert(e2)
            }
            
            if distMap.edgelib[e2] == nil {

                distMap.edgelib[e2] = [e1]
            } else if (distMap.edgelib[e2]?.isEmpty)! {

                distMap.edgelib[e2]?.insert(e1)
            } else {

                distMap.edgelib[e2]?.insert(e1)
            }
        }

        // for the sake of completion of edgelib
        // edgelib is the store of adjacent vertices
        // no adjacent vertices = [] array
        for v in verticesArr[run] {

            if distMap.edgelib[v] == nil {

                distMap.edgelib[v] = []
            }

            distMap.traversed[v] = false
        }

        // approach v1.0
        //        func recursiveDistCalc(_ s:Int, _ lvl: Int, _ distMap: DistMap) {
        //
        //            let distSeed = 6
        //
        //            if distMap.edgelib[s]!.isEmpty {
        //
        //                return
        //            }
        //
        //            let curlvl = lvl + 1
        //
        //            for vertex in distMap.edgelib[s]! {
        //
        //                if vertex == distMap.s {
        //
        //                    continue
        //                }
        //
        //                if distMap.traversed[vertex] == nil || distMap.traversed[vertex]! >= curlvl {
        //
        //                    distMap.traversed[vertex] = curlvl
        //
        //                    if distMap.map![vertex-1] == -1 || distMap.map![vertex-1] >= curlvl * distSeed {
        //
        //                        distMap.map![vertex-1] = curlvl * distSeed
        //                    }
        //
        //                    recursiveDistCalc(vertex, curlvl, distMap)
        //                }
        //            }
        //        }

        // approach v2.0
        func recursiveDistCalc2(_ adj: Set<Int>, _ lvl: Int,_ distMap: DistMap) {

            if adj.isEmpty {

                return
            }

            let distSeed = 6

            distMap.next = []

            let curlvl = lvl + 1

            _ = adj.map({

                if distMap.map![$0-1] == -1 || distMap.map![$0-1] >= curlvl * distSeed {

                    distMap.map![$0-1] = curlvl * distSeed
                }

                distMap.traversed[$0] = true

                _ = distMap.edgelib[$0]!.map({

                    if !($0 == distMap.s! || distMap.traversed[$0]!) {

                        distMap.next.insert($0)
                    }
                })
            })
            
            //            for vertex in adj {
            //
            //                if distMap.map![vertex-1] == -1 || distMap.map![vertex-1] >= curlvl * distSeed {
            //
            //                    distMap.map![vertex-1] = curlvl * distSeed
            //                }
            //
            //                distMap.traversed.append(vertex)
            //
            //                _ = distMap.edgelib[vertex]!.map({
            //
            //                    if !($0 == distMap.s! || distMap.traversed.contains($0) || adj.contains($0)) {
            //
            //                        distMap.next.append($0)
            //                    }
            //                })
            //
            //                innerloop: for innerv in distMap.edgelib[vertex]! {
            //
            //                    if innerv == distMap.s! || distMap.traversed.contains(innerv) || adj.contains(innerv){
            //
            //                        continue innerloop
            //                    }
            //
            //                    distMap.next.append(innerv)
            //                }
            //            }

            if distMap.next.isEmpty {

                return
            }

            return recursiveDistCalc2(distMap.next, curlvl, distMap)
        }

        //        recursiveDistCalc(s, 0, distMap)

        recursiveDistCalc2(distMap.edgelib[sArr[run]]!, 0, distMap)

        var op = " "

        _ = distMap.map!.map({

            if $0 == 0 {

                op += ""
            } else {

                op += String($0) + " "
            }
        })

//        for v in verticesArr[run] {
//
//            if v == sArr[run] {
//
//                continue
//            } else {
//
//                op += String(distMap.map![v-1]) + " "
//            }
//        }

        print(op.trimmingCharacters(in: CharacterSet(charactersIn:" ")))
    }

    return
}
/// END - Breadth First Search: Shortest Reach

// Viral advertising
public func viralAdvertising() {

    let shareCount = 3.0
    var startCount = 5.0

    guard let n = Int(readLine()!) else {

        return
    }

    if !( n <= 50 && n > 0 ) { return }

    var ml:Int = 0

    for _ in 0 ..< n {

        ml += Int(floor(startCount/2))
        startCount = floor(startCount/2) * shareCount
    }
    
    print(ml)
}

// Kangaroo
public func kangaroo() {
    
    let i:[Int] = readLine(strippingNewline: true)!.characters
        .split(separator: " ")
        .map({Int(String($0))!})

    let t = (x1:i[0],v1:i[1],x2:i[2],v2:i[3])

    switch t {
    case let x where x.x1 > x.x2 && x.v1 < x.v2,
         let x where x.x1 < x.x2 && x.v1 > x.v2:
        switch (x.x1 - x.x2) % (x.v2 - x.v1) {
        case 0:
            print("YES")
        default:
            print("NO")
        }
    case let x where x.x1 == x.x2 && x.v1 == x.v2:
        print("YES")
    default:
        print("NO")
    }

    return
}

// Plus Minus
public func plusMinus() {

    guard let n = readLine(strippingNewline: true), let N:Int = Int(n) else {
        exit(0)
    }

    // the map and reduce high-order functions make it easier to work on arrays and sets and strings
    // love this!
    let array:[Int] = readLine(strippingNewline: true)!.characters.split(separator: " ").map({Int(String($0))!})
    var negCount = 0.0
    var posCount = 0.0
    var zCount = 0.0

    for i in array {

        switch i {

            case 0: zCount += 1
            case let x where x < 0: negCount += 1
            case let x where x > 0: posCount += 1
            default: break
        }
    }
    
    print(posCount/Double(N))
    print(negCount/Double(N))
    print(zCount/Double(N))
}


// Diagonal Diff of matrix
public func diagonalDiff() {

    guard let n = readLine(strippingNewline: true), let N = Int(n) else {
        exit(0)
    }

    var sumLeft  = 0
    var sumRight = 0
    var diff:Int
    var leftIndex  = 0
    var rightIndex = N - 1
    

    for _ in 0 ..< N {

        if (leftIndex >= N) || (rightIndex < 0){
            
            break
        }

        let splits:[Int] = readLine(strippingNewline: true)!.characters.split(separator: " ").map(String.init).map(
            {
                (x:String) -> Int in
                return Int(x)!
            })

        sumLeft += splits[leftIndex]
        sumRight += splits[rightIndex]
        leftIndex += 1
        rightIndex -= 1
    }

    diff = sumLeft - sumRight

    print(diff)
}
