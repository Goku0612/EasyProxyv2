FROM ghcr.io/realbestia1/easyproxy:latest

# Identificativo del tuo fork
ENV USER_FORK=Goku0612

# Configurazione per Hugging Face
ENV PORT=7860
ENV ENABLE_WARP=true
ENV WARP_MODE=wireproxy
ENV ENABLE_FLARESOLVER=false

# --- QUESTE RIGHE SONO FONDAMENTALI PER IL TUO FORK ---
WORKDIR /app
COPY . .
RUN chmod +x entrypoint.sh
# -----------------------------------------------------

EXPOSE 7860

CMD ["/bin/bash", "/app/entrypoint.sh"]
