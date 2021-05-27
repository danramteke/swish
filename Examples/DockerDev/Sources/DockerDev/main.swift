import SwishKit

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
		""", dependsOn: [createNetwork])
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
""", dependsOn: [createNetwork, createPostgresVolume])

func isContainerRunning(_ name: String) -> String {
	"docker ps -aq -f name=\(name) --format \"{{ .Names }}\" | grep -w \(name)"
}

struct ContainerIsRunning: ParsableShellQuery {
	let name: String
	var text: String {
		"docker ps -aq -f name=\(name) --format \"{{ .Names }}\" | grep -w \(name)"
	}

	typealias Output = Bool

	func parse(shellOutput output: String) -> Bool {
		!output.isEmpty
	}
}

let isRedisRunning = ContainerIsRunning(name: redisName)
let isPostgresRunning = ContainerIsRunning(name: postgresName)
let isNetworkExisting = sh("docker network -aq -f name=\(networkName) | grep -w \(networkName)", .equals(networkName))
let isVolumeExisting = sh("docker volume -aq -f name=\(volumeName) | grep -w \(volumeName)", .equals(volumeName))

let teardownRedis = sh("docker rm -f \(redisName)")
let teardownPostgres = sh("docker rm -f \(postgresName)")
let teardownVolume = sh("docker volume rm \(volumeName)", dependsOn: [teardownPostgres])
let teardownNetwork = sh("docker network rm \(networkName)", dependsOn: [teardownRedis, teardownPostgres])

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

