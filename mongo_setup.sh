#!/bin/bash

LOCK="conf.lock" 

if [ ! -f $LOCK ]; then

    chmod 600 /data/file.key

    /usr/bin/mongod --replSet "rs0" --bind_ip_all --keyFile "/data/file.key" &

    sleep 5

    mongo <<EOF
    var cfg = {
            "_id": "rs0",
            "version": 1,
            "members": [
                {
                    "_id": 0,
                    "host": "mongodb:27017",
                    "priority": 2
                },
                {
                    "_id": 1,
                    "host": "mongodb2:27017",
                    "priority": 0
                },
                {
                    "_id": 2,
                    "host": "mongodb3:27017",
                    "priority": 0
                }
            ]
        };
        rs.initiate(cfg, { force: true });
EOF

    sleep 25

    mongo <<EOF
    use admin;
    admin = db.getSiblingDB("admin");
    admin.createUser(
        {
            user: "$MONGO_USERNAME",
            pwd: "$MONGO_PASSWORD",
            roles: [ { role: "root", db: "admin" } ]
        });
EOF

    mongod --shutdown

    touch $LOCK

fi

eval /usr/bin/mongod --replSet "rs0" --bind_ip_all --keyFile "/data/file.key" 