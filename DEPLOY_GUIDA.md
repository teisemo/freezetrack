# 🚀 Deploy di FreezeTrack — Guida passo passo

## Opzione consigliata: GitHub Pages (gratuito, HTTPS, permanente)

### Prerequisiti
- Un account GitHub gratuito → [github.com/signup](https://github.com/signup)
- I file nella cartella `deploy/` che hai scaricato

---

### Passo 1 — Crea un nuovo repository

1. Vai su **[github.com/new](https://github.com/new)**
2. Nome repository: `freezetrack`
3. Lascia **Public**
4. **NON** spuntare "Add a README"
5. Clicca **Create repository**

---

### Passo 2 — Carica i file (metodo senza Git)

Se non hai Git installato, puoi fare tutto dal browser:

1. Nella pagina del repository appena creato, clicca **"uploading an existing file"**
2. Trascina **tutti** i file e le cartelle dalla cartella `deploy/`:
   ```
   deploy/
   ├── index.html
   ├── manifest.json
   ├── sw.js
   └── icons/
       ├── icon-192.png
       └── icon-512.png
   ```
3. Clicca **Commit changes**

> ⚠️ **Importante**: carica il *contenuto* della cartella deploy, non la cartella stessa.
> I file devono stare nella root del repository.

---

### Passo 2 (alternativa) — Upload con Git da terminale

```bash
# Clona il repo vuoto
git clone https://github.com/TUO_USERNAME/freezetrack.git
cd freezetrack

# Copia i file nella cartella del repo
cp -r /percorso/della/cartella/deploy/* .

# Pusha
git add .
git commit -m "Initial deploy FreezeTrack"
git push origin main
```

---

### Passo 3 — Attiva GitHub Pages

1. Vai su **Settings** → **Pages** (menu a sinistra)
2. Sotto "Source", seleziona **Deploy from a branch**
3. Branch: **main** / cartella: **/ (root)**
4. Clicca **Save**
5. Attendi 1-2 minuti

---

### Passo 4 — Accedi all'app!

La tua app sarà disponibile su:

```
https://TUO_USERNAME.github.io/freezetrack/
```

Apri questo URL da **qualsiasi dispositivo** (telefono, tablet, PC).

---

### Passo 5 — Installa come app su Android

1. Apri l'URL in **Chrome** sul telefono
2. Apparirà un banner "Aggiungi a schermata Home", oppure:
   - Tocca il menu **⋮** in alto a destra
   - Tocca **"Installa app"** o **"Aggiungi a schermata Home"**
3. L'app apparirà come un'icona nel tuo launcher!

Su **iPhone/iPad**: apri in Safari → tocca il pulsante condividi → "Aggiungi a schermata Home".

---

## Alternative gratuite

### Netlify (drag & drop, zero configurazione)

1. Vai su **[app.netlify.com/drop](https://app.netlify.com/drop)**
2. Trascina la cartella `deploy/` nella pagina
3. Fatto! Ricevi un URL tipo `https://random-name.netlify.app`
4. Puoi rinominarlo in: Settings → Domain management → `freezetrack.netlify.app`

**Pro**: Deploy istantaneo, basta trascinare.

### Cloudflare Pages

1. Vai su **[pages.cloudflare.com](https://pages.cloudflare.com)**
2. Collega il tuo repo GitHub oppure fai upload diretto
3. URL gratuito con HTTPS

---

## Note importanti

| Requisito | Perché |
|-----------|--------|
| **HTTPS obbligatorio** | La fotocamera e lo scanner barcode funzionano solo su HTTPS. Tutte le opzioni sopra forniscono HTTPS gratuitamente. |
| **Dati in localStorage** | I dati sono salvati nel browser di ogni dispositivo. Non si sincronizzano tra dispositivi diversi. |
| **Funziona offline** | Grazie al Service Worker, dopo il primo caricamento l'app funziona anche senza internet. |

---

## FAQ

**I dati si sincronizzano tra telefono e PC?**
No, localStorage è locale per ogni browser/dispositivo. Per una sincronizzazione cloud
servirebbe un backend (es. Firebase, Supabase) — posso aiutarti ad aggiungerlo se vuoi.

**Posso usare un dominio personalizzato?**
Sì! Su GitHub Pages: Settings → Pages → Custom domain. Su Netlify: Domain settings.

**Come aggiorno l'app?**
Aggiorna i file nel repository GitHub e GitHub Pages si aggiorna automaticamente in 1-2 minuti.
