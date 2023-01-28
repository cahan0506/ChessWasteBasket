$inputPGN = 
@”

[Event       "?"]
[Site        ""]
[Date        "1994.??.??"]
[Round       "4"]
[White       "AB"]
[Black       "CH"]
[Result      "0-1"]
[WhiteElo    "2115"]
[BlackElo    "2155"]
[NIC         "QP 9.1"]

1. d2-d4 d7-d5 2. Bc1-g5 Nb8-d7 3. Ng1-f3 Ng8-f6 4. e2-e3 e7-e6 5. Bf1-d3 
Bf8-e7 6. O-O O-O 7. Nb1-d2 b7-b6 8. c2-c3 Bc8-b7 9. Qd1-b1 h7-h6 10. Bg5xf6 
Be7xf6 11. e3-e4 d5xe4 12. Bd3xe4 c7-c6 13. Rf1-e1 Qd8-c7 14. Nd2-c4 Ra8-d8 
15. Qb1-c2 Bb7-a6 16. Nc4-e5 Bf6xe5 17. Nf3xe5 Nd7xe5 18. Be4-h7 Kg8-h8 
19. Re1xe5 c6-c5 20. Ra1-d1 c5xd4 21. c3xd4 Rd8xd4 22. Re5-e1 Qc7xc2 
23. Bh7xc2 Rf8-d8 24. f2-f4 Rd4-d2 25. f4-f5 Ba6-b7 26. f5xe6 f7xe6 27. g2-g3 
Rd2-g2 

                             0-1
“@

$inputPGN

$regex = '(.*)([1-8])(-)([a-h])(.*)'

while ($inputPGN -match $regex) {
  $inputPGN = $inputPGN -replace $regex, '$1$2$4$5'
}
$inputPGN