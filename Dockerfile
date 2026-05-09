# Usa l'immagine pubblica per evitare l'errore 403 Forbidden
FROM ghcr.io/realbestia1/easyproxy:latest

# Identificativo del tuo fork
ENV USER_FORK=Goku0612

# Configurazione per Hugging Face
ENV PORT=7860
ENV ENABLE_WARP=true
ENV WARP_MODE=wireproxy
ENV ENABLE_FLARESOLVER=false

# --- PASSWORD DEL PROXY ---
# Questa è la password che dovrai inserire nell'app Vavoo/Stremio
ENV PROXY_PASSWORD=Dosm3nico6

# --- CONFIGURAZIONE AMBIENTE ---
WORKDIR /app
COPY . .
RUN chmod +x entrypoint.sh

# Porta esposta per Hugging Face
EXPOSE 7860

# Comando di avvio del servizio
CMD ["/bin/bash", "/app/entrypoint.sh"]
