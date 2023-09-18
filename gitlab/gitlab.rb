external_url 'http://bzcloud.net'
gitlab_rails['initial_root_password'] = File.read('/run/secrets/gitlab_root_password').gsub("\n", "")
gitlab_rails['initial_shared_runners_registration_token'] = "d1bKPYwKVWvCeSJ_eKcD"