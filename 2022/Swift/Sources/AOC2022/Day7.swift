//
//  Day7.swift
//
//
//  Created by Kamaal M Farah on 06/12/2022.
//

import Foundation
import ShrimpExtensions

let ACCEPTED_FILE_SIZE = 100_000
let AVAILABLE_DISK_SIZE = 70_000_000
let NEEDED_UNUSED_SPACE = 30_000_000

extension AOC2022 {
    public enum Day7: DayScaffold {
        public static let resourceName = "day7"

        public enum Part1 {
            public static func execute(with input: String) -> Int {
                let directory = makeDirectory(input)

                let acceptedFileSizes = getAcceptedFileSizes(directory)
                return acceptedFileSizes
            }
        }

        public enum Part2 {
            public static func execute(with input: String) -> Int {
                let directory = makeDirectory(input)

                let spaceUsed = directory.fileSizes
                let unusedSpace = AVAILABLE_DISK_SIZE - spaceUsed
                let directoriesToDelete = getDirectoriesToDelete(directory, acceptedFileSize: NEEDED_UNUSED_SPACE - unusedSpace)
                return directoriesToDelete
                    .reduce(Int.max, {
                        if $1.fileSizes < $0 {
                            return $1.fileSizes
                        }

                        return $0
                    })
            }
        }
    }
}

private func makeDirectory(_ input: String) -> Directory {
    var listingInDirectory = false
    var path: [String] = []
    let pathTree = Directory(name: "/")

    for line in input.splitLines {
        if line.hasPrefix("$ cd") {
            listingInDirectory = false
            let pathToNavigateTo = String(line.range(from: 4)).trimmingByWhitespacesAndNewLines
            switch pathToNavigateTo {
            case "/":
                path = []
            case "..":
                _ = path.popLast()
            default:
                path.append(pathToNavigateTo)
            }
        } else if line.hasPrefix("$ ls") {
            listingInDirectory = true
        } else if listingInDirectory {
            if line.hasPrefix("dir") {
                continue
            }

            let splittedOutput = line.split(separator: " ")
            let fileSize = Int(splittedOutput[0])!
            let filename = String(splittedOutput[1])
            var newPath = pathTree
            for pathComponent in path {
                if newPath.directories.find(by: \.name, is: pathComponent) == nil {
                    newPath.addDirectory(Directory(name: pathComponent))
                }
                let createdPath = newPath.directories.find(by: \.name, is: pathComponent)!
                newPath = createdPath
            }
            if newPath.files.find(by: \.name, is: filename) == nil {
                newPath.addFile(FileInfo(size: fileSize, name: filename))
            }
        }
    }

    return pathTree
}

private func getDirectoriesToDelete(_ directory: Directory, acceptedFileSize: Int) -> [Directory] {
    var directoriesToDelete: [Directory] = []
    if directory.fileSizes > acceptedFileSize {
        directoriesToDelete = directoriesToDelete.appended(directory)
    }

    for directory in directory.directories {
        let otherDirectoriesToDelete = getDirectoriesToDelete(directory, acceptedFileSize: acceptedFileSize)
        for otherDirectoryToDelete in otherDirectoriesToDelete {
            directoriesToDelete = directoriesToDelete.appended(otherDirectoryToDelete)
        }
    }

    return directoriesToDelete
}

private func getAcceptedFileSizes(_ directory: Directory) -> Int {
    var acceptedFileSizes = 0
    if directory.fileSizes < ACCEPTED_FILE_SIZE {
        acceptedFileSizes += directory.fileSizes
    }

    for directory in directory.directories {
        acceptedFileSizes += getAcceptedFileSizes(directory)
    }

    return acceptedFileSizes
}

private struct FileInfo: CustomStringConvertible {
    let size: Int
    let name: String
    fileprivate var depth: Int?

    // - MARK: CustomStringConvertible

    var description: String {
        "- \(name) (file, size=\(size))"
    }

    fileprivate func setDepth(_ depth: Int) -> FileInfo {
        FileInfo(size: size, name: name, depth: depth)
    }
}

private class Directory: CustomStringConvertible {
    let name: String
    private(set) var files: [FileInfo]
    private(set) var directories: [Directory]
    private var depth: Int?

    init(name: String, files: [FileInfo] = [], directories: [Directory] = []) {
        self.name = name
        self.files = files
        self.directories = directories
    }

    var fileSizes: Int {
        let currentDirectoryFileSizes = files.reduce(0, { $0 + $1.size })
        let directoriesFileSizes = directories.reduce(0, { $0 + $1.fileSizes })
        return currentDirectoryFileSizes + directoriesFileSizes
    }

    func addDirectory(_ directory: Directory) {
        directories = directories.appended(directory)
    }

    func addFile(_ file: FileInfo) {
        files = files.appended(file)
    }

    // - MARK: CustomStringConvertible

    var description: String {
        let directoryWithDepth = setDepth()
        var representation = "- \(name) (dir)"
        for directory in directoryWithDepth.directories {
            let spaces = (0..<directory.depth!).map({ _ in "  " }).joined()
            representation += "\n\(spaces)\(directory.description)"
        }
        for file in directoryWithDepth.files {
            let spaces = (0..<file.depth!).map({ _ in "  " }).joined()
            representation += "\n\(spaces)\(file.description)"
        }
        return representation
    }

    @discardableResult
    private func setDepth(depth: Int = 0) -> Directory {
        if self.depth != nil {
            return self
        }

        files = files.map({ $0.setDepth(depth + 1) })
        self.depth = depth
        for directory in directories {
            directory.setDepth(depth: depth + 1)
        }
        return self
    }
}
