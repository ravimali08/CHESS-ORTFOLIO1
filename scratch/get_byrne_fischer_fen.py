def get_byrne_fischer_fen():
    # Initial board layout: uppercase = White, lowercase = Black
    # Rows from 8 to 1 (index 0 to 7)
    board = [
        ['r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'], # 8
        ['p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'], # 7
        ['.', '.', '.', '.', '.', '.', '.', '.'], # 6
        ['.', '.', '.', '.', '.', '.', '.', '.'], # 5
        ['.', '.', '.', '.', '.', '.', '.', '.'], # 4
        ['.', '.', '.', '.', '.', '.', '.', '.'], # 3
        ['P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'], # 2
        ['R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R']  # 1
    ]

    # Convert algebraic coordinates to index (row, col)
    # File: a-h (0-7), Rank: 1-8 (7-0)
    def pos(s):
        file = ord(s[0]) - ord('a')
        rank = 8 - int(s[1])
        return rank, file

    def move(from_sq, to_sq):
        fr, fc = pos(from_sq)
        tr, tc = pos(to_sq)
        board[tr][tc] = board[fr][fc]
        board[fr][fc] = '.'

    def set_sq(sq, piece):
        r, c = pos(sq)
        board[r][c] = piece

    # We will simulate the exact moves of Byrne vs Fischer 1956:
    # 1. Nf3 Nf6 2. c4 g6 3. Nc3 Bg7 4. d4 O-O
    move('g1', 'f3'); move('g8', 'f6')
    move('c2', 'c4'); move('g7', 'g6')
    move('b1', 'c3'); move('f8', 'g7')
    move('d2', 'd4')
    # 4... O-O (Black King f8->g8, Rook h8->f8? No, King e8->g8, Rook h8->f8)
    move('e8', 'g8'); move('h8', 'f8')
    # 5. Bf4 d5
    set_sq('c1', '.'); set_sq('f4', 'B') # Bf4
    move('d7', 'd5')
    # 6. Qb3 dxc4
    set_sq('d1', '.'); set_sq('b3', 'Q') # Qb3
    set_sq('d5', '.'); set_sq('c4', 'p') # dxc4 (Black pawn captures c4)
    # 7. Qxc4 c6
    set_sq('b3', '.'); set_sq('c4', 'Q') # Qxc4
    move('c7', 'c6')
    # 8. e4 Nbd7
    move('e2', 'e4')
    move('b8', 'd7')
    # 9. Rd1 Nb6
    move('a1', 'd1')
    move('d7', 'b6')
    # 10. Qc5 Bg4
    move('c4', 'c5')
    set_sq('c8', '.'); set_sq('g4', 'b') # Bg4
    # 11. Bg5 Na4
    move('f4', 'g5')
    move('b6', 'a4')
    # 12. Qa3 Nxc3
    move('c5', 'a3')
    set_sq('a4', '.'); set_sq('c3', 'n') # Nxc3 (Black knight captures c3)
    # 13. bxc3 Nxe4
    set_sq('b2', '.'); set_sq('c3', 'P') # bxc3 (White pawn captures c3)
    set_sq('f6', '.'); set_sq('e4', 'n') # Nxe4 (Black knight captures e4)
    # 14. Bxe7 Qb6
    set_sq('g5', '.'); set_sq('e7', 'B') # Bxe7
    set_sq('d8', '.'); set_sq('b6', 'q') # Qb6
    # 15. Bc4 Nxc3
    set_sq('f1', '.'); set_sq('c4', 'B') # Bc4
    set_sq('e4', '.'); set_sq('c3', 'n') # Nxc3 (Black knight captures c3)
    # 16. Bc5 Rfe8+
    move('e7', 'c5') # Bc5
    move('f8', 'e8') # Rfe8+
    # 17. Kf1 Be6
    move('e1', 'f1') # Kf1 (White King moves e1->f1)
    
    # We want the position right BEFORE Fischer plays 17... Be6.
    # At this point, the Black bishop is still on g4, and Black is to move.
    
    # Let's print the board and FEN
    fen_rows = []
    for r in range(8):
        empty = 0
        row_str = ""
        for c in range(8):
            cell = board[r][c]
            if cell == '.':
                empty += 1
            else:
                if empty > 0:
                    row_str += str(empty)
                    empty = 0
                row_str += cell
        if empty > 0:
            row_str += str(empty)
        fen_rows.append(row_str)
        
    fen = "/".join(fen_rows) + " b - - 0 17"
    print("Generated FEN:", fen)

if __name__ == '__main__':
    get_byrne_fischer_fen()
