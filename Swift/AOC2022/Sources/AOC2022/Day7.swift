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
                    .sorted(by: { $0.fileSizes < $1.fileSizes })
                    .first?
                    .fileSizes ?? 0
            }
        }
    }
}

private func makeDirectory(_ input: String) -> Directory {
    var listingInDirectory = false
    var path: [String] = []
    let pathTree = Directory(name: "/", files: [], directories: [])

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
                    newPath.addDirectory(Directory(name: pathComponent, files: [], directories: []))
                }
                if let createdPath = newPath.directories.find(by: \.name, is: pathComponent) {
                    newPath = createdPath
                }
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

private struct FileInfo {
    let size: Int
    let name: String
}

private class Directory {
    let name: String
    private(set) var files: [FileInfo]
    private(set) var directories: [Directory]

    init(name: String, files: [FileInfo], directories: [Directory]) {
        self.name = name
        self.files = files
        self.directories = directories
    }

    var fileSizes: Int {
        let currentDirectoryFileSizes = files.reduce(0, { $0 + $1.size })
        let directoriesFileSizes = directories.reduce(0, { $0 + $1.fileSizes })
        return currentDirectoryFileSizes + directoriesFileSizes
    }

    private func flatten(_ previous: [Directory]) -> [Directory] {
        if previous.isEmpty {
            return previous
        }

        return previous.flatMap(\.directories)
    }

    func addDirectory(_ directory: Directory) {
        directories = directories.appended(directory)
    }

    func addFile(_ file: FileInfo) {
        files = files.appended(file)
    }
}
