package egress

hosts := {"hacker-news.firebaseio.com", "github.com"}

deny contains $"{input.request.host} is not allowed" if {
	not input.request.host in hosts
}

deny contains $"{input.request.method} is not allowed, only GET" if {
	input.request.host == "hacker-news.firebaseio.com"
	input.request.method != "GET"
}
