export default function handler(req, res) {
  // A mock leaderboard API for the backend
  res.status(200).json([
    { rank: 1, name: 'Magnus Carlsen', elo: 2832 },
    { rank: 2, name: 'Fabiano Caruana', elo: 2805 },
    { rank: 3, name: 'Hikaru Nakamura', elo: 2789 },
    { rank: 4, name: 'Ding Liren', elo: 2780 },
    { rank: 5, name: 'Ian Nepomniachtchi', elo: 2770 }
  ]);
}
