ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_AMD64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_AMD64}
EXPOSE 7476
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="7476/tcp"

ARG VERSION
RUN curl -fsSL "https://github.com/autobrr/qui/releases/download/v${VERSION}/qui_${VERSION}_linux_x86_64.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=0 && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chmod +x "${APP_DIR}/qui"

COPY root/ /
RUN find /etc/s6-overlay/s6-rc.d -name "run*" -execdir chmod +x {} +
