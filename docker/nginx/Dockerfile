FROM nginx:alpine

# Crée un répertoire pour les fichiers de configuration des templates
RUN mkdir -p /etc/nginx/templates

# Copie le fichier template Nginx de configuration dans le conteneur
COPY default.conf.template /etc/nginx/templates/default.conf.template

# Installe envsubst qui fait partie du package gettext pour substituer les variables d'environnement
# RUN apk add --no-cache gettext

# Script d'entrée pour faire la substitution des variables avant de démarrer Nginx
# CMD ["/bin/sh", "-c", "envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
CMD ["nginx", "-g", "daemon off;"]