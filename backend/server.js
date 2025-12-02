const express = require("express");
const app = express();

app.use(express.json());

app.get('/api/health', (req, res) => {
    res.json({ status: "ok", message: "DONIA backend running" });
});

app.listen(5000, () => {
    console.log("Backend running on port 5000");
});
