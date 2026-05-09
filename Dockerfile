# Usa l'immagine già pronta di realbestia1 come base
FROM ghcr.io/realbestia1/easyproxy:latest

# Identificativo del fork di Goku0612
ENV USER_FORK=Goku0612

# Configurazioni per Hugging Face
ENV PORT=7860
ENV ENABLE_WARP=true
ENV WARP_MODE=wireproxy

# Disabilita FlareSolverr come suggerito nell'ultimo screen
ENV ENABLE_FLARESOLVER=false

EXPOSE 7860

# Avvia usando l'entrypoint del tuo fork
CMD ["/bin/bash", "/app/entrypoint.sh"]
