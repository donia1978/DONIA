export const metadata = {
  title: "DONIA",
  description: "DONIA 2026 frontend"
};

export default function RootLayout({ children }) {
  return (
    <html lang="fr">
      <body>{children}</body>
    </html>
  );
}
