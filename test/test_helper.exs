{:ok, kv_pid} = KV.start_link
Process.register(kv_pid, :kv)

ExUnit.start()
