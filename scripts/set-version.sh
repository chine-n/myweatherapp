# echo "APP_VERSION=\$(cat ~/weather-app-deployment.yaml)"
APP_VERSION=\$(cat pom.xml | grep version | head -2 | awk -F'[<>]' '/version/ {print $3}')
sed -i \"s/$SET_APP_VERSION/\$APP_VERSION/\" ../weather-app-deployment.yaml


