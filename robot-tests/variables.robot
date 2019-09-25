*** Variables ***
### LOCAL ###
${CLIENT_ID}                      wkXLlC9h3k0jxIx7oLllxpFVU89Dxgi7O8FYZyfX
${CLIENT_SECRET}                  KiKRft8MajLabQId7pjSsa3OfvJAXN9NENi0tVRTX3Vbthr6iClEDZZtbyGuD9M8UbKpK2E8R4xJYUolZxg1nVa1iZwhQPi5ionOKdpIs4de2bmUaZ0qWi4MdBmdwDvF
${API_USER_USERNAME}              admin
${API_USER_PASSWORD}               {{ some-secret }}
${MIDGARD_ANGULAR_BASE_URL}       http://localhost:9000
${MIDGARD_REACT_BASE_URL}         http://localhost:9001
${BIFROST_BASE_URL}               http://localhost:8090
${DOCUMENTS_API_BASE_URL}         ${BIFROST_BASE_URL}/documents
${TIMETRACKING_API_BASE_URL}      ${BIFROST_BASE_URL}/timetracking
${CRM_API_BASE_URL}               ${BIFROST_BASE_URL}/crm
${LOCATION_API_BASE_URL}          ${BIFROST_BASE_URL}/locations
${PRODUCT_API_BASE_URL}           ${BIFROST_BASE_URL}/products

### DOCKER ###
${CLIENT_ID_docker}                      wkXLlC9h3k0jxIx7oLllxpFVU89Dxgi7O8FYZyfX
${CLIENT_SECRET_docker}                  KiKRft8MajLabQId7pjSsa3OfvJAXN9NENi0tVRTX3Vbthr6iClEDZZtbyGuD9M8UbKpK2E8R4xJYUolZxg1nVa1iZwhQPi5ionOKdpIs4de2bmUaZ0qWi4MdBmdwDvF
${API_USER_USERNAME_docker}              admin
${API_USER_PASSWORD_docker}               {{ some-secret }}
${MIDGARD_ANGULAR_BASE_URL_docker}       http://midgard-angular:9000
${MIDGARD_REACT_BASE_URL_docker}         http://midgard-react:9000
${BIFROST_BASE_URL_docker}               http://bifrost:8080
${DOCUMENTS_API_BASE_URL_docker}         ${BIFROST_BASE_URL}/documents
${TIMETRACKING_API_BASE_URL_docker}      ${BIFROST_BASE_URL}/timetracking
${CRM_API_BASE_URL_docker}               ${BIFROST_BASE_URL}/crm
${LOCATION_API_BASE_URL_docker}          ${BIFROST_BASE_URL}/locations
${PRODUCT_API_BASE_URL_docker}           ${BIFROST_BASE_URL}/products
