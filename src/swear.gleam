import gleam/list
import gleam/io

pub external type Promise(a)

if erlang {
  pub external fn async(fn() -> a) -> Promise(a)
    = "erlang_ffi" "async" 

  pub external fn await(Promise(a)) -> a
    = "erlang_ffi" "await"

  pub external fn then(Promise(a), fn(a) -> b) -> Promise(b)
    = "erlang_ffi" "await"
}

if javascript {
  pub external fn async(fn() -> a) -> Promise(a)
    = "js_ffi" "async" 

  pub external fn await(Promise(a)) -> a
    = "js_ffi" "await"

  pub external fn then(Promise(a), fn(a) -> b) -> Promise(b)
    = "js_ffi" "await"
}

fn download(string) {
  io.print("Downloading... " <> string <> "\n")
  "Fake file data"
}

fn all(promises: List(Promise(a))) -> Promise(List(a)) {
  use <- async
  promises
  |> list.map(await)
}

pub fn main() {
  let files = ["gleam.run", "callbackhell.com"]
  |> list.map(fn(string) {
      use <- async()
      download(string)
    })
  |> all()
  |> await()

  use <- async()
  io.print("This line will never execute")
}
