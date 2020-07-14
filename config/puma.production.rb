environment "production"

bind  "unix:///home/babywearing/app/shared/tmp/sockets/puma.sock"
pidfile "/home/babywearing/app/shared/tmp/pids/puma.pid"
state_path "/home/babywearing/app/shared/tmp/puma.state"
directory "/home/babywearing/app/current"

workers 1
threads 1,2

daemonize false

stdout_redirect "/home/babywearing/app/shared/log/puma.stdout.log", "/home/babywearing/app/shared/log/puma.stderr.log", true

activate_control_app 'unix:///home/babywearing/app/shared/tmp/sockets/pumactl.sock'

prune_bundler
