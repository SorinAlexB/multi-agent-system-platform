# if we have compiled .beam files we can use those like in this example
# otherwise we need to use:
# :code.load_file(ModuleName)
# :code.load_file(Recursion)

pid = spawn(Recursion, :agent_loop, ["task1"])
# IO.inspect(send(pid, {:task, "task2"}))
# IO.inspect(send(pid, :stop))
send(pid, {:task, "task2"})
send(pid, :stop)
