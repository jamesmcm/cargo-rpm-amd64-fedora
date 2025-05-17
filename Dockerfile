FROM fedora:latest

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH;



RUN set -eux; \
    dnf -y install openssl-devel; \
    dnf -y install @development-tools; \
	curl -o /tmp/install_rust.sh https://sh.rustup.rs; \
	sh /tmp/install_rust.sh -y ;

RUN dnf -y install rpm-build
RUN dnf -y install systemd-rpm-macros
ENV PATH=/usr/local/bin:/root/.cargo/bin:$PATH \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

RUN set -eux; \
    cargo install cargo-rpm;

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
