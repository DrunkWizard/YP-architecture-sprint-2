#!/bin/bash

# Init mongodb config server
docker compose exec -T configSrv mongosh --port 27017 <<EOF

rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
EOF

# Init mongodb shard1
docker compose exec -T shard1 mongosh --port 27018 <<EOF

rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1:27018" },
      ]
    }
);
EOF

# Init mongodb shard2
docker compose exec -T shard2 mongosh --port 27019 <<EOF

rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 1, host : "shard2:27019" }
      ]
    }
  );
EOF

# Init mongodb shard3
docker compose exec -T shard3 mongosh --port 27020 <<EOF

rs.initiate(
    {
      _id : "shard3",
      members: [
        { _id : 2, host : "shard3:27020" }
      ]
    }
  );
EOF


# Init mongodb router
docker compose exec -T mongos_router mongosh --port 27021 <<EOF

sh.addShard( "shard1/shard1:27018");
sh.addShard( "shard2/shard2:27019");
sh.addShard( "shard3/shard3:27020");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})
db.helloDoc.countDocuments() 
EOF
