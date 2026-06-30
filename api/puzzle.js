export default function handler(req, res) {
  // A mock chess puzzle API for the backend
  res.status(200).json({
    id: 452,
    name: 'The Immortal Variation',
    fen: 'r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3',
    solution: ['Nxe5', 'Nxe5', 'd4'],
    difficulty: 'Hard',
    eloReward: 50,
    hint: 'Look for a discovered attack involving the knight.'
  });
}
