import SwishKit
import ArgumentParser

let env = "dev"
let networkName = "\(env)-network"
let volumeName = "\(env)-pgdata"
let postgresName = "\(env)-postgres"
let redisName = "\(env)-redis"


let createNetwork = sh("docker network create \(networkName)")
let runRedis = sh("""
		docker run -d --rm --name \(redisName) \
		--platform linux/amd64 \
		--network-alias \(redisName) \
		--network \(networkName) \
		-p 6379:6379 \
		redis:alpine
		""")
let createPostgresVolume = sh("docker volume create \(volumeName)")
let runPostgres = sh("""
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
		super.init(text, interpretation: .equals(name))
	}
}

let isRedisRunning = ContainerIsRunning(name: redisName)
let isPostgresRunning = ContainerIsRunning(name: postgresName)
let isNetworkExisting = sh("docker network -aq -f name=\(networkName)", .equals(networkName))
let isVolumeExisting = sh("docker volume -aq -f name=\(volumeName)", .equals(volumeName))

let teardownRedis = sh("docker rm -f \(redisName)")
let teardownPostgres = sh("docker rm -f \(postgresName)")
let teardownVolume = sh("docker volume rm \(volumeName)")
let teardownNetwork = sh("docker network rm \(networkName)")

func teardownAll() throws {
	if try isRedisRunning() {
		try teardownRedis()
	}

	if try isPostgresRunning() {
		try teardownRedis()
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
}

struct DockerDev: ParsableCommand {
	@Argument(help: "the action. Options are: \(Action.allCases.map { $0.rawValue }.joined(separator: ", "))")
	var action: Action

	mutating func run() throws {
		switch action {
		case .setup:
			try setupAll()
		case .teardown:
			try teardownAll()
		}
	}
}

DockerDev.main()
