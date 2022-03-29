export API_ENDPOINT="https://api.tinybird.co"
#export TB_TOKEN="p.eyJ1IjogIjk2MTEwOTNhLWJkM2UtNGI0ZS1hZTZlLTc1OWY3NDNmZDg3NyIsICJpZCI6ICIwZjhhNjc1Mi1iM2EwLTQ3YWUtYTUzMi1lZGI2MTliZWYyMjQifQ.XuXn-xTQ5g92p3wqL6Pq7xNXqq-WKhf7PQhGVVOX-68"
echo "pushing changes"

for file in $(git diff --name-only); do \
    echo $file;
    if [[ $file == *.pipe ]]
    then
        echo "hola"
        tb push $file --force --fixtures --no-check
    fi
done