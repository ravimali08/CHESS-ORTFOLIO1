$port = 8000
$localPath = "C:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")

Write-Output "Starting local web server..."
try {
    $listener.Start()
    Write-Output "Server running successfully!"
    Write-Output "You can open your browser and visit: http://localhost:$port/"
    Write-Output "To stop the server, close the command or terminal."
    
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $urlPath = $request.Url.LocalPath.TrimStart('/')
        if ($urlPath -eq "") { $urlPath = "index.html" }
        
        $filePath = Join-Path $localPath $urlPath
        if (Test-Path $filePath -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            
            # Set Content-Type
            if ($urlPath.EndsWith(".html")) { $response.ContentType = "text/html; charset=utf-8" }
            elseif ($urlPath.EndsWith(".css")) { $response.ContentType = "text/css" }
            elseif ($urlPath.EndsWith(".js")) { $response.ContentType = "application/javascript" }
            elseif ($urlPath.EndsWith(".png")) { $response.ContentType = "image/png" }
            elseif ($urlPath.EndsWith(".jpg") -or $urlPath.EndsWith(".jpeg")) { $response.ContentType = "image/jpeg" }
            elseif ($urlPath.EndsWith(".svg")) { $response.ContentType = "image/svg+xml" }
            
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $bytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        }
        $response.Close()
    }
} catch {
    Write-Output "Error: $_"
} finally {
    $listener.Stop()
}
