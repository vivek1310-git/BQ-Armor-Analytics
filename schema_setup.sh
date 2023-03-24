gcloud config set project ${PROJECT_ID}

project_id=${PROJECT_ID}
dataset=${DATASET}
region=${REGION}

cd ~/data

bq load --replace --location=${REGION} --project_id=${PROJECT_ID} --skip_leading_rows=1 ${DATASET}.geolite2_city_blocks_ipv4 GeoLite2-City-Blocks-IPv4.csv "network:STRING,geoname_id:INTEGER,registered_country_geoname_id:INTEGER,represented_country_geoname_id:INTEGER,is_anonymous_proxy:BOOL,is_satellite_provider:BOOL,postal_code:STRING,latitude:FLOAT64,longitude:FLOAT64,accuracy_radius:FLOAT64"
  
bq load --replace --location=${REGION} --project_id=${PROJECT_ID} --skip_leading_rows=1 ${DATASET}.geolite2_city_blocks_ipv6 GeoLite2-City-Blocks-IPv6.csv "network:STRING,geoname_id:INTEGER,registered_country_geoname_id:INTEGER,represented_country_geoname_id:INTEGER,is_anonymous_proxy:BOOL,is_satellite_provider:BOOL,postal_code:STRING,latitude:FLOAT64,longitude:FLOAT64,accuracy_radius:FLOAT64"
  
bq load --replace --location=${REGION} --project_id=${PROJECT_ID} --skip_leading_rows=1 ${DATASET}.geolite2_city_locations GeoLite2-City-Locations-en.csv "geoname_id:INTEGER,locale_code:STRING,continent_code:STRING,continent_name:STRING,country_iso_code:STRING,country_name:STRING,subdivision_1_iso_code:STRING,subdivision_1_name:STRING,subdivision_2_iso_code:STRING,subdivision_2_name:STRING,city_name:STRING,metro_code:STRING,time_zone:STRING,is_in_european_union:BOOL"

# build_sql="CREATE OR REPLACE FUNCTION gee.get_ndvi_month(lon float64,lat float64, farm_name STRING, year int64, month int64) RETURNS STRING REMOTE WITH CONNECTION \`${project_id}.us.gcf-ee-conn\` OPTIONS ( endpoint'${endpoint}')"

build_sql="CREATE OR REPLACE TABLE \`${project_id}.${dataset}.geolite2_city_ipv4\` AS SELECT NET.IP_FROM_STRING(REGEXP_EXTRACT(network, r'(.*)/' )) network_bin,CAST(REGEXP_EXTRACT(network, r'/(.*)' ) AS INT64) mask,l.city_name, l.country_iso_code, l.country_name, b.latitude, b.longitude FROM \`${project_id}.${dataset}.geolite2_city_blocks_ipv4\` b JOIN `ip_address.geolite2_city_locations` l USING(geoname_id)"

bq query --use_legacy_sql=false ${build_sql}

build_sql="CREATE OR REPLACE TABLE \`${project_id}.${dataset}.geolite2_city_ipv6\` AS SELECT  NET.IP_FROM_STRING(REGEXP_EXTRACT(network, r'(.*)/' )) network_bin,CAST(REGEXP_EXTRACT(network, r'/(.*)' ) AS INT64) mask,l.city_name, l.country_iso_code, l.country_name, b.latitude, b.longitude FROM \`${project_id}.${dataset}.geolite2_city_blocks_ipv6\` b JOIN `ip_address.geolite2_city_locations` l USING(geoname_id);

bq query --use_legacy_sql=false ${build_sql}


build_mv_sql="CREATE MATERIALIZED VIEW \`${project_id}.${dataset}.log_request_mv\` as SELECT httpRequest.requestUrl,httpRequest.remoteIp,jsonpayload_type_loadbalancerlogentry.enforcedsecuritypolicy.priority,jsonpayload_type_loadbalancerlogentry.enforcedsecuritypolicy.outcome,jsonpayload_type_loadbalancerlogentry.enforcedsecuritypolicy.name,TIMEstamp(timestamp) date_timete,count(*) CNT FROM \`${project_id}.${dataset}.requests\` where jsonpayload_type_loadbalancerlogentry.enforcedsecuritypolicy.name is not null group by 1,2,3,4,5,6

bq query --use_legacy_sql=false ${build_mv_sql}

build_vw_sql="create view \`${project_id}.${dataset}.log_report\` as WITH source_of_ip_addresses AS (SELECT *, REGEXP_REPLACE(remoteIp, 'xxx', '0')  ip FROM \`${project_id}.${dataset}.log_request_mv\`) SELECT requestUrl,remoteIp,priority,outcome,name,date_timete as date_time,date(date_timete) as date,CNT,city_name,country_name,latitude,longitude,ST_GEOGPOINT(longitude, latitude) AS geopoint FROM (SELECT * FROM (SELECT *, NET.SAFE_IP_FROM_STRING(ip) & NET.IP_NET_MASK(4, mask) network_bin FROM source_of_ip_addresses, UNNEST(GENERATE_ARRAY(9,32)) mask WHERE BYTE_LENGTH(NET.SAFE_IP_FROM_STRING(ip)) = 4) JOIN \`${project_id}.${dataset}.geolite2_city_ipv4\` USING (network_bin, mask))"

bq query --use_legacy_sql=false ${build_vw_sql}

echo ""
echo " Setup is complete please validate all the tables and views in the dataset "
echo ""