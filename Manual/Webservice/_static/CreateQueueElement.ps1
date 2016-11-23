param(
[string]$definition,
[string]$url
)

Invoke-RestMethod -Uri "$url/api/queue?definition=$definition"