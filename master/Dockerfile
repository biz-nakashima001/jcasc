FROM jenkins/jenkins:lts

ARG JAVA_OPTS
# タイムゾーン
ENV JAVA_OPTS=-Duser.timezone=Asia/Tokyo
# 初回起動時のウィザード無し
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

# jenkinsプラグインの導入
COPY plugins_extra.txt /usr/share/jenkins/ref/plugins_extra.txt
RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins_extra.txt
