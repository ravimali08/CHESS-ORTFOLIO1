# Initialize chess board (uppercase = White, lowercase = Black)
# Rows 8 to 1 (indices 0 to 7)
$board = @(
    @('r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'), # 8
    @('p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'), # 7
    @('.', '.', '.', '.', '.', '.', '.', '.'), # 6
    @('.', '.', '.', '.', '.', '.', '.', '.'), # 5
    @('.', '.', '.', '.', '.', '.', '.', '.'), # 4
    @('.', '.', '.', '.', '.', '.', '.', '.'), # 3
    @('P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'), # 2
    @('R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R')  # 1
)

function Get-Index($sq) {
    $file = [int][char]$sq[0] - [int][char]'a'
    $rank = 8 - [int][string]$sq[1]
    return @($rank, $file)
}

function Move-Piece($from, $to) {
    $fromIdx = Get-Index $from
    $toIdx = Get-Index $to
    $board[$toIdx[0]][$toIdx[1]] = $board[$fromIdx[0]][$fromIdx[1]]
    $board[$fromIdx[0]][$fromIdx[1]] = '.'
}

function Set-Square($sq, $piece) {
    $idx = Get-Index $sq
    $board[$idx[0]][$idx[1]] = $piece
}

# Simulate Karpov vs Kasparov Game 16 1985
# 1. e4 c5 2. Nf3 e6 3. d4 cxd4 4. Nxd4 Nc6
Move-Piece 'e2' 'e4'; Move-Piece 'c7' 'c5'
Move-Piece 'g1' 'f3'; Move-Piece 'e7' 'e6'
Move-Piece 'd2' 'd4'; Set-Square 'c5' '.'; Set-Square 'd4' 'n' # Black pawn c5 captures d4 Knight? No, White d4 captures c5? No, cxd4: Black c5 pawn captures White d4 pawn.
Set-Square 'd4' 'p' # d4 is now black pawn
Set-Square 'c5' '.'
# 4. Nxd4 Nc6: White Knight f3 captures d4 pawn, Black Knight b8 to c6
Set-Square 'f3' '.'; Set-Square 'd4' 'N'
Move-Piece 'b8' 'c6'
# 5. Nb5 d6
Move-Piece 'd4' 'b5'
Move-Piece 'd7' 'd6'
# 6. c4 Nf6
Move-Piece 'c2' 'c4'
Move-Piece 'g8' 'f6'
# 7. N1c3 a6
Move-Piece 'b1' 'c3'
Move-Piece 'a7' 'a6'
# 8. Na3 d5
Move-Piece 'b5' 'a3'
Move-Piece 'd6' 'd5'
# 9. cxd5 exd5
Set-Square 'c4' '.'; Set-Square 'd5' 'p' # cxd5
Set-Square 'e6' '.'; Set-Square 'd5' 'p' # exd5 (Wait, Black pawn on e6 captures d5, so d5 is black pawn)
# 10. exd5 Nb4
Set-Square 'e4' '.'; Set-Square 'd5' 'P' # exd5 (White pawn on e4 captures d5)
Move-Piece 'c6' 'b4'
# 11. Be2 Bc5
Set-Square 'f1' '.'; Set-Square 'e2' 'B'
Set-Square 'f8' '.'; Set-Square 'c5' 'b'
# 12. O-O O-O
# White castles: King e1->g1, Rook h1->f1
Move-Piece 'e1' 'g1'; Move-Piece 'h1' 'f1'
# Black castles: King e8->g8, Rook h8->f8
Move-Piece 'e8' 'g8'; Move-Piece 'h8' 'f8'
# 13. Bf3 Bf5
Move-Piece 'e2' 'f3'
Set-Square 'c8' '.'; Set-Square 'f5' 'b'
# 14. Bg5 Re8
Set-Square 'c1' '.'; Set-Square 'g5' 'B'
Move-Piece 'f8' 'e8'
# 15. Qd2 b5
Set-Square 'd1' '.'; Set-Square 'd2' 'Q'
Move-Piece 'b7' 'b5'
# 16. Rad1
Move-Piece 'a1' 'd1'

# We want the position right BEFORE Black plays 16... Nd3.
$fenRows = @()
for ($r = 0; $r -lt 8; $r++) {
    $empty = 0
    $rowStr = ""
    for ($c = 0; $c -lt 8; $c++) {
        $cell = $board[$r][$c]
        if ($cell -eq '.') {
            $empty++
        } else {
            if ($empty -gt 0) {
                $rowStr += [string]$empty
                $empty = 0
            }
            $rowStr += $cell
        }
    }
    if ($empty -gt 0) {
        $rowStr += [string]$empty
    }
    $fenRows += $rowStr
}

$fen = ($fenRows -join "/") + " b - - 0 16"
Write-Output "FEN: $fen"
