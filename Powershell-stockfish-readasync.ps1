$psi = New-Object System.Diagnostics.ProcessStartInfo;
$psi.FileName = "C:\Users\WDAGUtilityAccount\Downloads\stockfish_15.1_win_x64_avx2\stockfish-windows-2022-x86-64-avx2.exe"; #CHANGE process file
$psi.UseShellExecute = $false;
$psi.RedirectStandardInput = $true;
$psi.RedirectStandardOutput = $true;

$uciPositions = @(
  "position startpos moves d2d4",
  "position fen rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR w KQkq - 0 2"
)

$movetime = 1000
$multipv = 3

$global:lastMultiPV1 = ""

function readUCIInput($p)
{
  $Timeout = 2 ## seconds
  $timer = [Diagnostics.Stopwatch]::StartNew()

  if ($null -eq $task) {
    $task = $p.StandardOutput.ReadLineAsync()
  }

  while ($true) {
    if ($task.IsCompleted) {
      $task.Result

      if ($task.Result.Contains("multipv 1 score cp ")) {
        $global:lastMultiPV1 = $task.Result
      }

      if (@("uciok", "readyok", "Checkers:", "bestmove").Contains($task.Result.Split(" ")[0])) {
        break
      } else {
        $task = $p.StandardOutput.ReadLineAsync();
      }
    }
    else {
      if ($timer.Elapsed.TotalSeconds -gt $Timeout) {
        break
      } else {
        Start-Sleep -m 50
      }
    }
  }
}

$p = [System.Diagnostics.Process]::Start($psi);

$p.StandardInput.writeLine("uci")
readUCIInput($p)

$p.StandardInput.writeLine("isready")
readUCIInput($p)

if ($multipv -gt 1) {
  $p.StandardInput.writeLine("setoption name MultiPV value " + ($multipv))
}

$p.StandardInput.writeLine("ucinewgame")

foreach ($currPosition in $uciPositions) {
  $p.StandardInput.WriteLine($currPosition);
  $p.StandardInput.WriteLine("d");
  readUCIInput($p)
  $p.StandardInput.WriteLine("go movetime " + ($movetime));
  readUCIInput($p)
  $global:lastMultiPV1
}

$p.StandardInput.WriteLine("quit");
$task = $null
