'use strict';

const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Token latihan — BUKAN JWT sungguhan. Pola header-nya yang dilatih.
const TOKEN_LATIHAN = process.env.TOKEN_LATIHAN || 'token-latihan-modul-07';

let catatan = [
  { id: 1, judul: 'Contoh', isi: 'Catatan pertama. Silakan ganti.' },
];
let idBerikut = 2;

function wajibToken(req, res, next) {
  const header = req.headers.authorization ?? '';
  if (header !== `Bearer ${TOKEN_LATIHAN}`) {
    return res.status(401).json({
      pesan: 'Token tidak sah atau kedaluwarsa',
    });
  }
  next();
}

function wajibJudul(req, res, next) {
  const judul = String(req.body?.judul ?? '').trim();
  if (judul.length < 3) {
    return res.status(400).json({
      pesan: 'Judul minimal 3 huruf. Validasi ini hidup di server, bukan hanya di form HP.',
    });
  }
  req.body.judul = judul;
  next();
}

app.get('/', (_req, res) => {
  res.json({ ok: true, layanan: 'catatan' });
});

app.post('/login', (req, res) => {
  const nama = String(req.body?.nama ?? '').trim();
  if (!nama) {
    return res.status(400).json({ pesan: 'Nama wajib diisi' });
  }
  res.json({ token: TOKEN_LATIHAN, nama });
});

app.get('/catatan', (req, res) => {
  const limit = Math.min(Number(req.query.limit) || 20, 50);
  const skip = Number(req.query.skip) || 0;
  res.json({
    total: catatan.length,
    skip,
    limit,
    data: catatan.slice(skip, skip + limit),
  });
});

app.get('/catatan/:id', (req, res) => {
  const item = catatan.find((c) => c.id === Number(req.params.id));
  if (!item) {
    return res.status(404).json({ pesan: 'Catatan tidak ketemu' });
  }
  res.json(item);
});

app.post('/catatan', wajibToken, wajibJudul, (req, res) => {
  const item = {
    id: idBerikut++,
    judul: req.body.judul,
    isi: String(req.body.isi ?? ''),
  };
  catatan.push(item);
  res.status(201).json(item);
});

app.put('/catatan/:id', wajibToken, wajibJudul, (req, res) => {
  const i = catatan.findIndex((c) => c.id === Number(req.params.id));
  if (i < 0) {
    return res.status(404).json({ pesan: 'Catatan tidak ketemu' });
  }
  catatan[i] = {
    ...catatan[i],
    judul: req.body.judul,
    isi: String(req.body.isi ?? ''),
  };
  res.json(catatan[i]);
});

app.delete('/catatan/:id', wajibToken, (req, res) => {
  const i = catatan.findIndex((c) => c.id === Number(req.params.id));
  if (i < 0) {
    return res.status(404).json({ pesan: 'Catatan tidak ketemu' });
  }
  const [hapus] = catatan.splice(i, 1);
  res.json(hapus);
});

const port = Number(process.env.PORT) || 3000;
app.listen(port, () => {
  console.log(`Mendengar di http://localhost:${port}`);
});
