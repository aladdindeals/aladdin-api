namespace :sidekiq do
  desc 'Quieten sidekiq'
  task :quiet do
    on roles(:app) do
      puts capture("pgrep -f 'sidekiq' | xargs kill -TSTP")
    end
  end

  desc 'Restart Sidekiq'
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :restart, :sidekiq
      execute :sudo, :systemctl, 'daemon-reload'
    end
  end
end