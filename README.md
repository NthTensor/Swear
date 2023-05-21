# Swear
*Set Loose the Dark Forces of Callback-Hell!*

Swear is a *Very Cursed* cross-platform concurrency library for Gleam, built with promises, and targeting modern browsers, node, deno, and the BEAM. Its definitely not the sort of thing you would to get mixed up in!

**WARNING** This package is incompatible with OTP and the standard sweet of tools built on top of it. Using this package would mean sacrificing most of whats good about the BEAM.

## What possessed you to make this?
Promises are the most Chaotic-Evil of concurrency primitives. They suck but they're really simple; simple enough to be implemented within Erlang. Is emulating JavaScript's promises on the BEAM the right way to do concurrency? Almost certainly not! In-fact we think a downright terrible idea! But it is tempting... especially when you realize that unlike JS, gleam has excellent syntax for managing deeply nested functions of the sort found only in the seventh circle of Callback-Hell.

## By what witchcraft was this accomplished?
Swear exposes a minimal async runtime in the form of a `Promise` type and three functions: `async`, `await` and `then`.

Calling `async` with a function `fn() -> a` returns `Promise(a)`.

```gleam
async(fn() { "Hello Async" })

fn async_example() {
  use <- async()
  "Hello Async"
}
```

Though `async` immediately returns a `Promise(a)` the body of the function executes asynchronously. Some runtimes may execute the function concurrently, the rest simply execute it asynchronously. If you care which is which you are too easily tempted and should not trifle with dark forces such as these.

Both `await` and `then` consume a `Promise(a)` by applying a function `fn(a) -> b` to the promised value. The former waits for the async code to complete, executes the function synchronously, then returns `b`. The latter returns `Promise(b)` immediately and executes the function asynchronously. 

Beware! The swearing of oaths is not to be taken lightly! Undefined behavior may result if you fail to `await` a promise. Calling `await` or `then` on the same promise more than once will consign your code to the abyss, where it will block forever. This library is inherently unsafe. You a have been worded!
