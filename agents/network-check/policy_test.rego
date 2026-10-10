package egress_test

import data.egress

test_allows_get_to_hacker_news if {
	count(egress.deny) == 0 with input as {"request": {"host": "hacker-news.firebaseio.com", "method": "GET", "path": "/v0/maxitem.json"}}
}

test_allows_git_over_https if {
	count(egress.deny) == 0 with input as {"request": {"host": "github.com", "method": "POST", "path": "/acme/docs.git/git-upload-pack"}}
}

test_denies_post_to_hacker_news if {
	egress.deny == {"POST is not allowed, only GET"} with input as {"request": {"host": "hacker-news.firebaseio.com", "method": "POST", "path": "/v0/maxitem.json"}}
}

test_denies_other_hosts if {
	egress.deny == {"example.com is not allowed"} with input as {"request": {"host": "example.com", "method": "GET", "path": "/"}}
}
