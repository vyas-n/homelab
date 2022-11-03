import "encoding/base64"

#regcred: [
	{
		hosts: ["https://index.docker.io/v1/", "docker.io"]
		user:  "wasabipull"
		pass:  "dckr_pat_yUDUKwsn7qMjTZOiWkBzzzxqF8Y"
		email: "vnellutla@wasabi.com"
	}, {
		hosts: ["ghcr.io"]
		user:  "vyas-n"
		pass:  "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"
		email: "vyasnellutla@gmail.com"
	},
]

{
	auths: {
		for regcred in #regcred {
			for host in regcred.hosts {
				"\(host)": {
					username: regcred.user
					password: regcred.pass
					email:    regcred.email
					auth:     base64.Encode(null, "\(username):\(password)")
				}
			}
		}
	}
}
