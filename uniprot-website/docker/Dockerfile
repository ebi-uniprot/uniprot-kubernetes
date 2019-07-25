FROM nginx

ARG GIT_REPO_DIR=/opt/uniprot-website

# update and install git and curl
# install NVM, NODE and NPM and build website files
# remove git and curl command
RUN set -x \
    && apt-get update \
    && apt-get install -y git curl \
    && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && nvm --version \
    && nvm install node \
    && node --version \
    && npm --version \
    && git clone --depth=50 https://github.com/ebi-uniprot/uniprot-website.git $GIT_REPO_DIR \
    && cd $GIT_REPO_DIR \
    && npm install \
    && npm run build \
    && mv $GIT_REPO_DIR/build/ /usr/share/nginx/html/uniprot-website \
    && rm -rf $GIT_REPO_DIR \
    && rm -rf $HOME/.nvm \
    && rm -rf $HOME/.npm \
    && apt-get autoremove -y git curl
