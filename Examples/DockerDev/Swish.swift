let swish = Swish(
  scripts: [
    "setup": "swift run DockerDev setup",
    "teardown": "swift run DockerDev teardown",
    "uname": "uname -m",
  ]
)