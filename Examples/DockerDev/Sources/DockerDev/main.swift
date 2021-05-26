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

let isRedisRunning = sh(isContainerRunning(redisName))
let isPostgresRunning = BooleanShellCommand(isContainerRunning(postgresName))
let isNetworkExisting = BooleanShellCommand("docker network -aq -f name=\(networkName) | grep -w \(networkName)", .equals(networkName))
let isVolumeExisting = BooleanShellCommand("docker volume -aq -f name=\(volumeName) | grep -w \(volumeName)", .equals(volumeName))

let teardownRedis = ShellCommand("docker rm -f \(redisName)", if: isRedisRunning)
let teardownPostgres = ShellCommand("docker rm -f \(postgresName)", if: isPostgresRunning)
let teardownVolume = ShellCommand("docker volume rm \(volumeName)", dependsOn: [teardownPostgres], if: isVolumeExisting)
let teardownNetwork = ShellCommand("docker network rm \(networkName)", dependsOn: [teardownRedis, teardownPostgres], if: isNetworkExisting)

func teardownAll() throws {
    if isRedisRunning.booleanValue {
        teardownRedis.run()
    }

    if isPostgresRunning.booleanValue {
        teardownRedis.run()
    }

    if isVolumeExisting.booleanValue {
        teardownVolume.run()
    }
}

let setupNest = Command(name: "setup", dependsOn: [
createNetwork,
runPostgres, runRedis,
createPostgresVolume
])

let teardownNest = Command(name: "teardown", dependsOn: [
teardownRedis,
teardownPostgres,
teardownNetwork,
teardownVolume
])

// let nest = Nest([
//     setupNest, teardownNest
// ])
// nest.build()

