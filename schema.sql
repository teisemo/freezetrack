-- ============================================================
-- FreezeTrack — Schema Supabase
-- Esegui questo SQL nell'editor SQL di Supabase (supabase.com)
-- Dashboard → SQL Editor → New query → Incolla → Run
-- ============================================================

-- 1. Tabella elettrodomestici
CREATE TABLE appliances (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('fridge', 'freezer')),
  name TEXT NOT NULL,
  icon TEXT DEFAULT '🧊',
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Tabella prodotti
CREATE TABLE items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  appliance_id UUID REFERENCES appliances(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  qty INTEGER NOT NULL DEFAULT 1,
  weight INTEGER DEFAULT 0,
  original_weight INTEGER DEFAULT 0,
  expiry DATE,
  barcode TEXT,
  photo TEXT,  -- base64 o URL
  added_date DATE DEFAULT CURRENT_DATE,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Indici per performance
CREATE INDEX idx_items_user ON items(user_id);
CREATE INDEX idx_items_appliance ON items(appliance_id);
CREATE INDEX idx_appliances_user ON appliances(user_id);

-- 4. Row Level Security (RLS) — ogni utente vede SOLO i suoi dati
ALTER TABLE appliances ENABLE ROW LEVEL SECURITY;
ALTER TABLE items ENABLE ROW LEVEL SECURITY;

-- Policy: gli utenti possono fare tutto sui PROPRI dati
CREATE POLICY "Users manage own appliances"
  ON appliances FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users manage own items"
  ON items FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- 5. Funzione per aggiornare updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER items_updated_at
  BEFORE UPDATE ON items
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- 6. Abilita Realtime per entrambe le tabelle
ALTER PUBLICATION supabase_realtime ADD TABLE appliances;
ALTER PUBLICATION supabase_realtime ADD TABLE items;
