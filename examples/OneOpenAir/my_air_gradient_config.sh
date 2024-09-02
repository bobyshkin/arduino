URL="${1}"
CType="Content-Type: application/json"

curl -X GET -H "${CType}" "${URL}"
curl -X PUT -H "${CType}" -d '{"ledBarMode":"off"}' "${URL}"
curl -X PUT -H "${CType}" -d '{"ledBarBrightness":50}' "${URL}"
curl -X PUT -H "${CType}" -d '{"displayBrightness":1}' "${URL}"
curl -X PUT -H "${CType}" -d '{"postDataToAirGradient":"false"}' "${URL}"
curl -X PUT -H "${CType}" -d '{"configurationControl":"local"}' "${URL}"
