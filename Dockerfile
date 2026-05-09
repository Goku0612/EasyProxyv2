# Usa l'immagine pubblica per evitare l'errore 403 Forbidden
FROM ghcr.io/realbestia1/easyproxy:latest

# Identificativo del tuo fork
ENV USER_FORK=Goku0612

# Configurazione per Hugging Face
ENV PORT=7860
ENV ENABLE_WARP=true
ENV WARP_MODE=wireproxy
ENV ENABLE_FLARESOLVER=false

# --- AGGIUNGI LA TUA PASSWORD QUI ---
# Sostituisci 'LaTuaPassword' con quella che scriverai nell'app Vavoo
ENV PROXY_PASSWORD=Dosm3nico6

# --- QUESTE RIGHE SONO FONDAMENTALI PER IL TUO FORK ---
WORKDIR /app
COPY . .
RUN chmod +x entrypoint.sh

EXPOSE 7860

CMD ["/bin/bash", "/app/entrypoint.sh"]
