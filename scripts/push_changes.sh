export API_ENDPOINT="https://api.tinybird.co"
#export TB_TOKEN="p.eyJ1IjogIjk2MTEwOTNhLWJkM2UtNGI0ZS1hZTZlLTc1OWY3NDNmZDg3NyIsICJpZCI6ICIwZjhhNjc1Mi1iM2EwLTQ3YWUtYTUzMi1lZGI2MTliZWYyMjQifQ.XuXn-xTQ5g92p3wqL6Pq7xNXqq-WKhf7PQhGVVOX-68"
echo "pushing changes"

#git fetch origin ${{ github.event.before }} --depth=1
#export DIFF=$( git diff --name-only ${{ github.event.before }} $GITHUB_SHA )
#echo "Diff between ${{ github.event.before }} and $GITHUB_SHA"
echo "$DIFF"

for file in $(git diff --name-only); do \
    echo $file;
    if [[ $file == *.pipe ]]
    then
        tb push $file --force --fixtures --no-check
    fi
done
echo "end"