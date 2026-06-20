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

# Simulate Byrne vs Fischer 1956
# 1. Nf3 Nf6 2. c4 g6 3. Nc3 Bg7 4. d4 O-O
Move-Piece 'g1' 'f3'; Move-Piece 'g8' 'f6'
Move-Piece 'c2' 'c4'; Move-Piece 'g7' 'g6'
Move-Piece 'b1' 'c3'; Move-Piece 'f8' 'g7'
Move-Piece 'd2' 'd4'
# Black castles: King e8->g8, Rook h8->f8
Move-Piece 'e8' 'g8'; Move-Piece 'h8' 'f8'
# 5. Bf4 d5
Set-Square 'c1' '.'; Set-Square 'f4' 'B'
Move-Piece 'd7' 'd5'
# 6. Qb3 dxc4
Set-Square 'd1' '.'; Set-Square 'b3' 'Q'
Set-Square 'd5' '.'; Set-Square 'c4' 'p'
# 7. Qxc4 c6
Set-Square 'b3' '.'; Set-Square 'c4' 'Q'
Move-Piece 'c7' 'c6'
# 8. e4 Nbd7
Move-Piece 'e2' 'e4'
Move-Piece 'b8' 'd7'
# 9. Rd1 Nb6
Move-Piece 'a1' 'd1'
Move-Piece 'd7' 'b6'
# 10. Qc5 Bg4
Move-Piece 'c4' 'c5'
Set-Square 'c8' '.'; Set-Square 'g4' 'b'
# 11. Bg5 Na4
Move-Piece 'f4' 'g5'
Move-Piece 'b6' 'a4'
# 12. Qa3 Nxc3
Move-Piece 'c5' 'a3'
Set-Square 'a4' '.'; Set-Square 'c3' 'n'
# 13. bxc3 Nxe4
Set-Square 'b2' '.'; Set-Square 'c3' 'P'
Set-Square 'f6' '.'; Set-Square 'e4' 'n'
# 14. Bxe7 Qb6
Set-Square 'g5' '.'; Set-Square 'e7' 'B'
Set-Square 'd8' '.'; Set-Square 'b6' 'q'
# 15. Bc4 Nxc3
Set-Square 'f1' '.'; Set-Square 'c4' 'B'
Set-Square 'e4' '.'; Set-Square 'c3' 'n'
# 16. Bc5 Rfe8+
Move-Piece 'e7' 'c5'
Move-Piece 'f8' 'e8'
# 17. Kf1
Move-Piece 'e1' 'f1'

# We want the position right BEFORE Fischer plays 17... Be6.
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

$fen = ($fenRows -join "/") + " b - - 0 17"
Write-Output "FEN: $fen"
