# Usa l'immagine originale standard
FROM ghcr.io/realbestia1/easyproxy:latest

# Variabili personali adattate per la porta standard di Render
ENV USER_FORK=Goku0612
ENV PORT=10000
ENV USE_WARP=true

# Passiamo a root per installare le utility di controllo rete
USER root

# Installiamo iproute2 per verificare lo stato della porta di WARP
RUN apt-get update && apt-get install -y iproute2 --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Creiamo l'entrypoint personalizzato in inglese per evitare i blocchi di sintassi
RUN cat << 'EOF' > /app/warp_entrypoint.sh
#!/bin/bash

# Configura il file .env locale per forzare l'uso di WARP
if [ -f /app/.env ]; then
    sed -i 's/USE_WARP=.*/USE_WARP=true/g' /app/.env
    sed -i 's/PROXY_URL=.*/PROXY_URL=socks5:\/\/127.0.0.1:1080/g' /app/.env
    echo "Configurazione .env impostata su WARP (Porta 1080)."
fi

# Avviamo l'entrypoint originale in background
echo "=== Avvio dei servizi di EasyProxy e Cloudflare WARP ==="
if [ -f /app/entrypoint.sh ]; then
    bash /app/entrypoint.sh &
elif [ -f /entrypoint.sh ]; then
    bash /entrypoint.sh &
else
    echo "ERRORE: Impossibile trovare l'entrypoint originale!"
    exit 1
fi

# Attendiamo che il proxy SOCKS5 di WARP sia online sulla porta 1080
echo "In attesa che Cloudflare WARP apra la porta 1080..."
for i in {1..30}; do
    if ss -lntu | grep -q :1080; then
        echo "WARP è attivo e connesso sulla porta 1080!"
        break
    fi
    sleep 1
done

# Manteniamo il container attivo monitorando i processi in background
wait
EOF

# Permessi di esecuzione dello script
RUN chmod +x /app/warp_entrypoint.sh

# Esponiamo la porta corretta per Render
EXPOSE 10000

# Avvia l'entrypoint ottimizzato per WARP
CMD ["/bin/bash", "/app/warp_entrypoint.sh"]
