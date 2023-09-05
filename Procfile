web: bin/rails server -p 8080
css: bin/rails tailwindcss:watch
worker: bundle exec sidekiq -C ./config/sidekiq.yml
release: rails db:migrate