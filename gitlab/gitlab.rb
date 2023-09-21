letsencrypt['enable'] = true
letsencrypt['auto_renew_hour'] = "12"
letsencrypt['auto_renew_minute'] = "30"
letsencrypt['auto_renew_day_of_month'] = "*/7"
external_url 'https://gitlab.bzcloud.net'
gitlab_rails['initial_root_password'] = File.read('/run/secrets/gitlab_root_password').gsub("\n", "")
gitlab_rails['initial_shared_runners_registration_token'] = "d1bKPYwKVWvCeSJ_eKcD"