defmodule Recursion do
# Recursion example
def factorial(0), do: 1
def factorial(n) when n > 0 do
n * factorial(n - 1)
end
# recursion-list sum
def sum(list), do: do_sum(list, 0)
defp do_sum([], acc), do: acc
defp do_sum([h | t], acc), do: do_sum(t, acc + h)
# Handle task for agent loop
defp handle_task(state, task) do
  [task | state]
end
# equivalent of while(true) loop
def agent_loop(state) do
new_state =
receive do
{:task, task} ->
handle_task(state, task)
:stop ->
IO.inspect(state, label: "List of tasks when stoppedd")
exit(:normal)
end
agent_loop(new_state)
end
end
