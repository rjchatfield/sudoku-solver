# Sudoku solver in Swift

I wrote this while on holiday in Swift Playground on iPad. That original code is available at: 

* [Original blog post](https://medium.com/@rjchatfield/sudoku-solver-in-swift-on-vacation-74e9166277ed)
* [Source w/ Value Types](https://gist.github.com/rjchatfield/649e46e4255c8e75255bd3ce7990a342)
* [Source w/ Reference Types](https://gist.github.com/rjchatfield/99bd88f196f23a8ca31058e4de912df2)

This is that code but run as a Swift Package, timed with XCTest in RELEASE (with a few small improvements).

* [Updated blog post](https://medium.com/@rjchatfield/sudoku-solver-in-swift-on-mac-5a8044d6790d)

## Timings

```
|        |   iPAD Playground  |    MAC #RELEASE   |    +Improvements   |
|        |    VAL   |   REF   |   VAL    |  REF   |  VAL   |    REF    |
|--------|----------|---------|----------|--------|--------|-----------|
|   Easy |      5 |     6 |   0.09 |  0.3 |  0.1ms |     0.4ms |
| Medium |    187ms |     9ms |   1.50ms |  0.5ms |  0.3ms |     0.5ms |
|   Hard |     52ms |    12ms |   0.50ms |  0.7ms |  0.2ms |     0.9ms |
| Expert | 31_551ms | 1_486ms | 189.00ms | 63.0ms | 32.0ms | 110-1.1ms |
```
