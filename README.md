<h1 align=center>Pin</h1>
<p align="center">
    <img src="https://user-images.githubusercontent.com/972877/143309795-78be2e80-05bd-4871-8a0c-2dcf4eb7cd4b.jpg" width="200" max-width="90%" alt=“Pin” />
</p>

# Introduction

### What
**Pin** is a thin wrapper around `NSLayoutConstraint` and `NSLayoutAnchor` to streamline the assembly of `AutoLayout` constraints.

### Why
Building rule-based layouts has been made easier with the introduction of `NSLayoutConstraint` and later `NSLayoutAnchor`. However, there is still room to further simplify commonly used operations without the verbosity and tedious setup of existing solutions. `Pin` addresses this with an intuitive and declarative API that leverages the builder pattern.

### How
`Pin` works by assembling a tree of nodes containing a view and its associated constraints, and once activated at the root it will start resolving constraints in a depth-first manner. If stored, a tree can also be deactivated. Deactivation removes any artifacts added in the activation process and reverts all constraints.

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

To further illustrate `Pin`'s API let's go over some common operations we may leverage when creating a layout.

To start let's import the dependencies.
```swift
import Pin
import UIKit
```

### Pinning to parent's edges

```swift
let parent = UIView()
let child = UIView()
parent.add {
    child.pin(to: .leading, .trailing, .top, .bottom) 
    // or 
    child.pin(to: .edges)
}
.activate()
``` 

### Centering within parent

```swift
let parent = UIView()
let child = UIView()
parent.add {
    child.pin(to: .centerX, centerY) 
    // or 
    child.pin(to: .center)
}
.activate()
``` 

### Sizing

```swift
let parent = UIView()
let child = UIView()
parent.add {
    child
        .size(height: 100)
        .pin(to: .width)
}
.activate()
```

### Containing a view within a view within a view ♾

```swift
let parent = UIView()
let child = UIView()
let grandChild = UIView()
parent.add {
    child
        .size(height: 100)
        .pin(to: .width)
        .add {
            grandChild
                .pin(to: .size, .center)
        }
}
.activate()
```

### Adding views using a custom containment strategy

```swift
extension Pinnable where Self: UIStackView {

    /// Adds the specified Pinnable's view as an arranged-subview under this `UIStackView`.
    public func stack(_ pinnables: Pinnable...) -> Pinnable {
        add(pinnables).contain(using: {
            self.addArrangedSubview($0.view)
        })
    }
}

let stackView = UIStackView()
let child = UIView()
stackView.stack(
    child.size(height: 100)
)
.activate()
```

### Extending `Pinnable` with custom operators

All operators (`pin()`, `center()`, `size()`, etc) in `Pin` are defined as extensions of the [`Pinnable`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Core/Pinnable.swift) protocol.

The [`center()`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Extensions/Resolvables/Pinnable%2BCenter.swift) operator, backed by the [`Center`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Extensions/Resolvables/Pinnable%2BCenter.swift) class, is an example of how `Pinnable` can be extended to create layouts not possible with the basic `pin(to:)`. While `pin(to: .center)` centers a view within a parent view, [`center(between:and:)`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Extensions/Resolvables/Pinnable%2BCenter.swift) centers a view within any two anchors regardless of where in the view hierarchy those anchors reside.

Operators can be built on top of existing operators, or can be backed by types that conform to either [`SuperResolvable`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Core/SuperResolvable.swift) or [`SelfResolvable`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Core/SelfResolvable.swift).

- A `SuperResolvable` represents the future assembly and activation of a constraint (or set of constraints) for a view that needs its designated superview to satisfy its layout requirements. [`Center`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Extensions/Resolvables/Pinnable%2BCenter.swift) and [`Pin`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Extensions/Resolvables/Pinnable%2BPin.swift) are examples of concrete `SuperResolvable`s.

- A `SelfResolvable` represents the future assembly and activation of a constraint (or set of constraints) for a view that satisfy its layout requirements without a superview. `NSLayoutConstraint` has implicit conformance to `SelfResolvable`. 
The [`size(width:height:)`](https://github.com/danielinoa/Pin/blob/main/Sources/Pin/Extensions/Resolvables/Pinnable%2BSize.swift) operator is a good application of `SelfResolvable` given that size constraints do not require a parent view to be satisfied.

# Contributing

Feel free to open an issue if you have questions about how to use Pin, or think you may have found a bug.

# Credits

`Pin` is primarily the work of [Daniel Inoa](https://github.com/danielinoa).
