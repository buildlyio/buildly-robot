*** Variables ***
### LOCAL ###
${CLIENT_ID}                      wkXLlC9h3k0jxIx7oLllxpFVU89Dxgi7O8FYZyfX
${CLIENT_SECRET}                  KiKRft8MajLabQId7pjSsa3OfvJAXN9NENi0tVRTX3Vbthr6iClEDZZtbyGuD9M8UbKpK2E8R4xJYUolZxg1nVa1iZwhQPi5ionOKdpIs4de2bmUaZ0qWi4MdBmdwDvF
${API_USER_USERNAME}              admin
${API_USER_PASSWORD}              {{ some-secret }}
${BUILDLY_UI_BASE_URL}            http://localhost:9001
${BUILDLY_BASE_URL}               http://localhost:8090
${PRODUCT_API_BASE_URL}           ${BUILDLY_BASE_URL}/products

### DOCKER ###
${CLIENT_ID_docker}                      wkXLlC9h3k0jxIx7oLllxpFVU89Dxgi7O8FYZyfX
${CLIENT_SECRET_docker}                  KiKRft8MajLabQId7pjSsa3OfvJAXN9NENi0tVRTX3Vbthr6iClEDZZtbyGuD9M8UbKpK2E8R4xJYUolZxg1nVa1iZwhQPi5ionOKdpIs4de2bmUaZ0qWi4MdBmdwDvF
${API_USER_USERNAME_docker}              admin
${API_USER_PASSWORD_docker}              {{ some-secret }}
${BUILDLY_UI_BASE_URL_docker}            http://buildly-ui:9000
${BUILDLY_BASE_URL_docker}               http://buildly:8080
${PRODUCT_API_BASE_URL_docker}           ${BUILDLY_BASE_URL}/products
