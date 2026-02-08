# 🚀 FreezeTrack + Supabase — Guida Configurazione

## Panoramica
- ✅ Autenticazione (email/password)
- ✅ Database cloud PostgreSQL
- ✅ Sincronizzazione real-time tra dispositivi
- ✅ Row Level Security (dati privati per utente)
- ✅ PWA installabile su Android/iOS

---

## Passo 1 — Crea progetto Supabase (5 min)

1. Vai su **[supabase.com](https://supabase.com)** → crea account gratuito
2. Clicca **New Project**
3. Name: `freezetrack`, scegli password DB e Region EU
4. Attendi ~2 minuti

---

## Passo 2 — Crea le tabelle (2 min)

1. Dashboard → **SQL Editor** → **New query**
2. Copia-incolla TUTTO il contenuto di `schema.sql`
3. Clicca **Run** ▶
4. Risultato: `Success. No rows returned` = tutto ok!

---

## Passo 3 — Copia le chiavi API (1 min)

1. Vai su **Settings → API**
2. Copia **Project URL** (es. `https://abcdefgh.supabase.co`)
3. Copia **anon public key** (inizia con `eyJ...`)
4. Apri `index.html`, cerca e sostituisci:

```javascript
const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';  // ← il tuo URL
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY';                   // ← la tua chiave
```

---

## Passo 4 — Configura autenticazione

1. Dashboard → **Authentication → Providers** → verifica che Email sia ON
2. Opzionale: in Auth → Settings disabilita "Confirm email" per test rapidi

---

## Passo 5 — Deploy

### Netlify (30 secondi)
1. Vai su [app.netlify.com/drop](https://app.netlify.com/drop)
2. Trascina la cartella con i file
3. Copia l'URL

### GitHub Pages
1. Crea repo `freezetrack` su GitHub
2. Carica i file → Settings → Pages → branch main
3. URL: `https://username.github.io/freezetrack/`

---

## Passo 6 — URL sito in Supabase

1. Dashboard → **Authentication → URL Configuration**
2. Site URL: il tuo URL di deploy
3. Aggiungi lo stesso URL in Redirect URLs

---

## Passo 7 — Installa sul telefono

- **Android**: Chrome → menu ⋮ → "Installa app"
- **iOS**: Safari → Condividi → "Aggiungi a schermata Home"
- Registra account → accedi da tutti i dispositivi!

---

## Come funziona

Quando modifichi un prodotto su un dispositivo, la modifica appare istantaneamente sugli altri grazie a WebSocket real-time di Supabase. I dati sono nel cloud, non si perdono cambiando telefono.

---

## Limiti piano gratuito Supabase

- 500 MB database (migliaia di prodotti, nessun problema)
- 50.000 utenti attivi/mese
- Progetto in pausa dopo 7 giorni di inattività (si riattiva aprendo l'app)
- 2 progetti gratuiti per account
