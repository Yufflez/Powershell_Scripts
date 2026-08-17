$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, 443)
$listener.Start()
Write-Host "Listening on 0.0.0.0:443. Press Ctrl+C to stop..."

try {
    while ($true) {
        if ($listener.Pending()) {
            $client = $listener.AcceptTcpClient()
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Connection received from: $($client.Client.RemoteEndPoint)" -ForegroundColor Green
            $client.Close()
        }
        Start-Sleep -Milliseconds 200
    }
}
finally {
    $listener.Stop()
    Write-Host "Listener stopped." -ForegroundColor Yellow
}
