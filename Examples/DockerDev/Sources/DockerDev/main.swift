import SwishKit
import ArgumentParser

let env = "DockerDev"
let networkName = "\(env)-network"
let volumeName = "\(env)-pgdata"
let postgresName = "\(env)-postgres"
let redisName = "\(env)-redis"


let createNetwork = cmd("docker network create \(networkName)")
let runRedis = cmd("""
docker run -d --rm --name \(redisName) \
--platform linux/amd64 \
--network-alias \(redisName) \
--network \(networkName) \
-p 6379:6379 \
redis:alpine
""")
let createPostgresVolume = cmd("docker volume create \(volumeName)")
let runPostgres = cmd("""
docker run -d --rm --name \(postgresName) \
--platform linux/amd64 \
--network-alias \(postgresName) \
--network \(networkName) \
-e POSTGRES_PASSWORD=password123 \
-p 5432:5432 \
--mount "source=\(postgresName),target=/var/lib/postgresql/data" \
postgres:12
""")

class ContainerIsRunning: ConcreteBooleanShellQuery {
	let name: String
	init(name: String) {
		self.name = name
		let text = "docker ps -aq -f name=\(name) --format \"{{ .Names }}\""
		super.init(text, .equalsTrimming(name))
	}
}

func containerIsRunning(name: String) -> ConcreteBooleanShellQuery {
	cmd("docker ps -aq -f name=\(name) --format \"{{ .Names }}\"", .equalsTrimming(name))
}

let isRedisRunning = ContainerIsRunning(name: redisName)
let isPostgresRunning = containerIsRunning(name: postgresName)
let isNetworkExisting = cmd("docker network ls -q -f name=\(networkName) --format \"{{ .Name }}\"", .equalsTrimming(networkName))
let isVolumeExisting = cmd("docker volume ls -q -f name=\(volumeName) --format \"{{ .Name }}\"", .equalsTrimming(volumeName))

let teardownRedis = cmd("docker rm -f \(redisName)")
let teardownPostgres = cmd("docker rm -f \(postgresName)")
let teardownVolume = cmd("docker volume rm \(volumeName)")
let teardownNetwork = cmd("docker network rm \(networkName)")

func teardownAll() throws {

	if try isRedisRunning() {
		try teardownRedis()
	}

	if try isPostgresRunning() {
		try teardownPostgres()
	}

	if try isVolumeExisting() {
		try teardownVolume()
	}

	if try isNetworkExisting() {
		try teardownNetwork()
	}
}

func setupAll() throws {
	try createNetwork()
	try createPostgresVolume()
	try runRedis()
	try runPostgres()
}

enum Action: String, ExpressibleByArgument, CaseIterable {
	case setup
	case teardown

	func run() throws {
		switch self {
		case .setup:
			try setupAll()
		case .teardown:
			try teardownAll()
		}
	}
}

struct DockerDev: ParsableCommand {
	@Argument(help: "the action. Options are: \(Action.allCases.map { $0.rawValue }.joined(separator: ", "))")
	var action: Action

	mutating func run() throws {
		try action.run()
		print("Success")
	}
}

DockerDev.main()
