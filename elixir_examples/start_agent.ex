# if we have compiled .beam files we can use those like in this example
# otherwise we need to use:
# :code.load_file(ModuleName)
# :code.load_file(Recursion)

pid = spawn(Recursion, :agent_loop, ["task1"])
# IO.inspect(send(pid, {:task, "task2"}))
# IO.inspect(send(pid, :stop))
send(pid, {:task, "task2"})
send(pid, :stop)


# data types examples:
#tuple: {:ok, 42}
# [head | tail]=[1,2,3] => head=1, tail=[2,3]
# [1,2] ++ [3,4] => [1,2,3,4]
# [1,2,3] -- [3] => [1,2]


#map
# agent = %{name:"agent1", status: :idle}
# name and status become atoms
# agent[:name]
# agent.name
# update the map using Map.put Map.put(agent, :status, :busy)

# keyword list
# [name: "agent1", timeout: 5000]
# e de fapt [{:name,"agent1"},{:timeout,5000}]


# ranges
# 1..10
# 1..10//2 => [1,3,5,7,9]

#read file
# case File.read("config.json") do
# {:ok, content} ->
# Jason.decode!(content)
# {:error, :enoent} ->
# %{}
# {:error, reason} ->
# raise "Failed: #{reason}"
# end

# match with guards
# defmodule Validator do
# def check(age) when is_integer(age) and age >= 18 do
# :adult
# end
# def check(age) when is_integer(age) and age >= 0 do
# :minor
# end
# def check(_), do: :invalid
# end

# destructuring on nested maps
# %{
# agent: %{name: name, capabilities: caps}
# } = %{
# agent: %{name: "Printer3D", capabilities: [:pla, :abs]},
# location: "Lab A"
# }
# => it will extract a map like this {name:"Printer3D", capabilities: [:pla, :abs]}, it ignores the location, good for filtering


#defmodule PrinterAgent do
# @moduledoc "Agent"
# @default_speed 50
# @doc "Create a new agent"
# def new(name, material) do
# %{
# name: name,
# material: material,
# speed: @default_speed,
# status: :idle,
# queue: []
# }
# end
# @doc "Evaluate the task"
# def can_handle?(agent, task) do
# task.material in supported_materials(agent) and
# agent.status == :idle
# end
# @doc "Estimate cost"
# def estimate_cost(agent, task) do
# volume = task.width * task.height * task.depth
# time = volume / agent.speed
# %{time: time, cost: time * material_rate(agent.material)}
# end
# # private functions
# defp supported_materials(%{material: :pla}), do: [:pla]
# defp supported_materials(%{material: :multi}), do: [:pla, :abs, :petg]
# defp supported_materials(_), do: [:pla]
# defp material_rate(:pla), do: 0.05
# defp material_rate(:abs), do: 0.08
# defp material_rate(:petg), do: 0.07
# defp

# def check_status(agent) do
#   case agent.status do
#     :idle -> "ok"
#     :busy -> "working"
#     _ -> "unknown"
#   end
# end


# cond - evaluate condition
# cond do
# cost < 10 -> :cheap
# cost < 50 -> :moderate
# true -> :expensive # default branch
# end

#use like this
# def categorize_cost(cost) do
#   cond do
#       cost <10 -> :cheap
#       true -> :expensive # catch-all
#   end
# end

# with - chain on pattern matches
# with {:ok, task} <- parse_request(raw),
# {:ok, agent} <- find_available_agent(task),
# {:ok, result} <- execute_task(agent, task) do
# {:ok, result}
# else
# end
# {:error, :parse_failed} -> {:error, "Invalid request"}
# {:error, :no_agent} -> {:error, "No available agent"}
# {:error, reason} -> {:error, "Failed: #{reason}"}

# if agent.status == :idle do
# accept_task(agent, task)
# else
# refuse_task(agent, task)
# end


# structs are more strict than maps. you can t add new parameters to a structure after creating one
#defmodule Task3D do
# @enforce_keys [:name, :material]
# defstruct [
# :name,
# :material,
# width: 0,
# height: 0,
# depth: 0,
# priority: :normal,
# status: :pending
# ]
# end
# you can use the struct like this
# task = %Task3D{name:"bracket",material: :pla,width:50}
# update like maps but in a safe way
# updated = %{task | status: :in_progress}

# # Protocol - polimorfism without inheritance
# defprotocol Printable do
# @doc "Format for printing"
# def format(data)
# end
# defimpl Printable, for: Task3D do
# def format(task) do
# "Task: #{task.name} [#{task.material}] #{task.status}"
# end
# end
# defimpl Printable, for: Map do
# def format(map), do: inspect(map)
# end
# # Usage
# Printable.format(task)
# # => "Task: Bracket [pla] pending"


# Spawn - create a new process
# pid = spawn(fn ->
#     receive do
#         {:hello, sender} ->
#             send(sender, {:response, "Hello!"})
#     end
# end)
# Trimite mesaj
# send(pid, {:hello, self()})
# # Get respond
# receive do
# {:response, msg} ->
# IO.puts(msg)
# after
# 5000 -> IO.puts("Timeout!")
# end

# lambda functions
# sum = fn a, b -> a + b end
# rez = sum.(5,3) => 8
# greeting = fn -> IO.puts("hello")
# greeting.() => "hello"


# # Processes as agents
# defmodule SimpleAgent do
# def start(name) do
# spawn(fn -> loop(%{name: name, status: :idle}) end)
# end
# defp loop(state) do
# receive do
# {:get_status, from} ->
# send(from, {:status, state.status})
# loop(state)
# {:set_status, new_status} ->
# loop(%{state | status: new_status})
# :stop ->
# IO.puts("#{state.name} stopping")
# # process stops
# end
# end
# end
# # Usage:
# pid = SimpleAgent.start("Ender3")
# send(pid, {:get_status, self()})
