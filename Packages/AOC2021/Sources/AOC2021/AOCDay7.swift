//
//  AOCDay7.swift
//  
//
//  Created by Kamaal M Farah on 06/12/2021.
//

import Foundation

struct AOCDay7 {
    public static let part1 = Part1()
    public static let part2 = Part2()

    public static let input: String? = {
        guard let inputURL = Bundle.module.url(forResource: "day7", withExtension: "txt") else { return nil }
        return try? String(contentsOf: inputURL, encoding: .utf8)
    }()

    private init() { }

    public struct Part1 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let horizontalPositions = input
                .splitCommas
                .compactMap({ Int(String($0).trimmingByWhitespacesAndNewLines) })

            var leastFuel = Int.max
            for (_, position) in horizontalPositions.enumerated() {
                var sum = 0
                for innerPosition in horizontalPositions {
                    let minimum: Int
                    let maximum: Int
                    if innerPosition > position {
                        minimum = position
                        maximum = innerPosition
                    } else {
                        minimum = innerPosition
                        maximum = position
                    }
                    sum += (maximum - minimum)
                }
                if sum < leastFuel {
                    leastFuel = sum
                }
            }

            return leastFuel
        }
    }

    public struct Part2 {
        fileprivate init() { }

        public func execute(with input: String) -> Int {
            let horizontalPositions = input
                .splitCommas
                .compactMap({ Int(String($0).trimmingByWhitespacesAndNewLines) })

            var leastFuel = Int.max
            for (index, position) in horizontalPositions.enumerated() {
                var sum = 0
                for innerPosition in horizontalPositions {
                    let minimum: Int
                    let maximum: Int
                    if innerPosition > position {
                        minimum = position
                        maximum = innerPosition
                    } else {
                        minimum = innerPosition
                        maximum = position
                    }
                    sum += (maximum - minimum)
                }
                if sum < leastFuel {
                    leastFuel = sum
                }
            }

            return leastFuel
        }
    }
}

class Node<T> {
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?

    init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    fileprivate var head: Node<T>?
    private var tail: Node<T>?

    public var isEmpty: Bool {
        head == nil
    }

    var first: Node<T>? {
        head
    }

    var last: Node<T>? {
        tail
    }

    func append(value: T) {
        let newNode = Node(value: value)

        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }

        tail = newNode
    }

    func nodeAt(index: Int) -> Node<T>? {
        if index >= 0 {
            var node = head
            var i = index

            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }

        return nil
    }

    func removeAll() {
        head = nil
        tail = nil
    }

    @discardableResult
    func remove(node: Node<T>) -> T {
        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev

        if next == nil {
            tail = prev
        }

        node.previous = nil
        node.next = nil

        return node.value
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += ", " }
        }
        return text + "]"
    }
}

struct Queue<T> {
    var list = LinkedList<T>()

    var isEmpty: Bool {
        list.isEmpty
    }

    func makeIterator() -> [T] {
        var values: [T] = []
        var currentNode: Node<T>? = list.head
        while currentNode != nil {
            if let value = currentNode?.value {
                values.append(value)
                currentNode = currentNode?.next
            } else {
                break
            }
        }
        return values
    }

    mutating func shiftLeft() {
        guard let discardedValue = dequeue() else { return }
        enqueue(discardedValue)
    }

    mutating func enqueue(_ element: T) {
        list.append(value: element)
    }

    mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else { return nil }

        list.remove(node: element)

        return element.value
    }

    func peek() -> T? {
        list.first?.value
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        list.description
    }
}
