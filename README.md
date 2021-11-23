<h1 align=center>Pin 📌</h1>

# Introduction

### What
**Pin** is a thin wrapper around `NSLayoutConstraint` and `NSLayoutAnchor` to streamline the assembly of `AutoLayout` constraints.

### Why
Building rule-based layouts has been made easier with the introduction of `NSLayoutConstraint` and later `NSLayoutAnchor`. However, there is still room to further simplify commonly used operations without the verbosity and tedious setup of existing solutions. `Pin` addresses this with an intuitive and declarative API that leverages the builder pattern.

### How
`Pin` works by assembling a tree of nodes containing a view and its associated constraints, and once activated at the root it will start resolving constraints in a depth-first manner. If stored, a tree can be also be deactivated. Deactivation removes any artifacts added in the activation process and reverts all constraints.

# Usage

## Installation

To install using Swift Package Manager, add this to the dependencies section in your `Package.swift` file:

```swift
.package(url: "https://github.com/danielinoa/Pin.git", .branch("main"))
```

## Integration

The primary API exposed by **Pin** is the `Pinnable` protocol, which is conformed to by `UIView` and exposes functions to layout a view.

The most used functions in this library are `add()`, `pin(to:)`, and `activate()`. 

- `add()` contains a view within a parent using a containment strategy. The default is `UIView.addSubview`.
- `pin(to:)` constrains a view within a parent using a any number of attributes (`leading`, `top`, `centerX`, `width`, etc).
- `activate()` actives the tree of constraints.

To further illustrate `Pin` let's go over some common operations we may leverage when creating a layout.

To start let's import the dependencies.
```swift
import Pin
import UIKit
```

### Pinning to parent's edges

```swift
let parent = UIView()
let child = UIView()
parent.add(
    child.pin(to: .leading, .trailing, .top, .bottom) 
    // or 
    child.pin(to: .edges)
)
.activate()
``` 

### Centering within parent

```swift
let parent = UIView()
let child = UIView()
parent.add(
    child.pin(to: .centerX, centerY) 
    // or 
    child.pin(to: .center)
)
.activate()
``` 

### Sizing

```swift
let parent = UIView()
let child = UIView()
parent.add(
    child
        .size(height: 100)
        .pin(to: .width)
)
.activate()
```

### Containing a view within a view within a view ♾

```swift
let parent = UIView()
let child = UIView()
let grandChild = UIView()
parent.add(
    child
        .size(height: 100)
        .pin(to: .width)
        .add(
            grandChild
                .pin(to: .size, .center)
        )
)
.activate()
```

# Contributing

Feel free to open an issue if you have questions about how to use Pin, or think you may have found a bug.

# Credits

`Pin` is primarily the work of Daniel Inoa.
