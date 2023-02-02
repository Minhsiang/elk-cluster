

ES_SERVER=$(cat .env | grep ES_SERVER)
ES_SERVER=${ES_SERVER/ES_SERVER=}

SVC=$(cat .env | grep SVC )
SVC=${SVC/SVC=/}

template_name=${SVC}

gene_post_data(){
  cat <<EOF
{
    "index_patterns": [
        "${template_name}*"
    ],
    "data_stream": {},
    "priority": 500,
    "template": {
        "settings": {
            "codec": "best_compression",
            "number_of_shards": 3,
            "number_of_replicas": 0,
            "refresh_interval": "30s",
            "index.translog.sync_interval": "1m",
            "index.translog.durability": "async",
            "index.translog.flush_threshold_size": "512mb",
            "index.routing.allocation.total_shards_per_node": 1,
            "index.lifecycle.name": "${template_name}-policy"
        },
        "mappings": {
            "properties": {
                "@timestamp": {
                    "type": "date_nanos"
                }
            }
        }
    }
}
EOF
}

echo "$(gene_post_data)" > ./config/template.json
