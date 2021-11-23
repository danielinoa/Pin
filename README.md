<h1 align=center>Pin 📌</h1>

# Introduction

### What
**Pin** is a thin wrapper around `NSLayoutConstraint` and `NSLayoutAnchor` to streamline the assembly of `AutoLayout` constraints.

### Why
Building rule-based layouts has been made easier with the introduction of `NSLayoutConstraint` and later `NSLayoutAnchor`. However, there is still room to further simplify commonly used operations without the verbosity and tedious setup of existing solutions. `Pin` addresses this with an elegant declarative API that leverages the builder pattern.

### How
`Pin` works by assembling a tree of nodes containing a view and its associated constraints, and once activated at the root it will start resolving constraints in a depth-first manner. If stored, a tree can be also be deactivated. Deactivation removes any artifacts added in the activation process and reverts all constraints.

## Usage

The primary API exposed by **Pin** is the `Pinnable` protocol, which is conformed to by `UIView` and exposes methods to layout a view.

# Installation

To install using Swift Package Manager, add this to the dependencies section in your `Package.swift` file:

`.package(url: "https://github.com/danielinoa/Pin.git", .branch("main"))`

# Contributing

Feel free to open an issue if you have questions about how to use Pin, or think you may have found a bug.
