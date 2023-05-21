-module(erlang_ffi).
-export([async/1, await/1, then/2]).

resolve(Value) ->
    receive
        {resolve, Tag, Pid} -> Pid ! {yield, Tag, Value}
    end.

async(Fun) -> spawn(fun () -> resolve(Fun()) end).

await(Pid) ->
    Tag = erlang:make_ref(),
    Self = self(),
    Pid ! {resolve, Tag, Self},
    receive
        {yield, Tag, Value} -> Value
    end.

then(Pid, Fun) ->
    spawn(
      fun () -> 
              Tag = erlang:make_ref(),
              Self = self(),
              Pid ! {resolve, Tag, Self},
              receive
                  {yield, Tag, Value} -> resolve(Fun(Value))
              end
      end).
    
