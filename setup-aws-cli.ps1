# AWS CLI Kurulum Script'i
# Bu script'i PowerShell'de çalıştırın

Write-Host "AWS CLI Kurulum Başlıyor..." -ForegroundColor Green

# .aws klasörünü oluştur
$awsPath = "$env:USERPROFILE\.aws"
if (-not (Test-Path $awsPath)) {
    New-Item -ItemType Directory -Force -Path $awsPath
    Write-Host "✓ .aws klasörü oluşturuldu: $awsPath" -ForegroundColor Green
} else {
    Write-Host "✓ .aws klasörü zaten mevcut" -ForegroundColor Yellow
}

# Credentials dosyası şablonu
$credentialsContent = @"
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID_HERE
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY_HERE
"@

# Config dosyası şablonu
$configContent = @"
[default]
region = us-east-1
output = json
"@

# Credentials dosyasını oluştur
$credentialsFile = "$awsPath\credentials"
if (-not (Test-Path $credentialsFile)) {
    $credentialsContent | Out-File -FilePath $credentialsFile -Encoding UTF8
    Write-Host "✓ credentials dosyası oluşturuldu" -ForegroundColor Green
} else {
    Write-Host "! credentials dosyası zaten mevcut (üzerine yazılmadı)" -ForegroundColor Yellow
}

# Config dosyasını oluştur
$configFile = "$awsPath\config"
if (-not (Test-Path $configFile)) {
    $configContent | Out-File -FilePath $configFile -Encoding UTF8
    Write-Host "✓ config dosyası oluşturuldu" -ForegroundColor Green
} else {
    Write-Host "! config dosyası zaten mevcut (üzerine yazılmadı)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SONRAKI ADIMLAR:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. AWS Console'a git ve Access Key oluştur:" -ForegroundColor White
Write-Host "   https://console.aws.amazon.com" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Credentials dosyasını düzenle:" -ForegroundColor White
Write-Host "   notepad $credentialsFile" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Access Key'leri yapıştır ve kaydet" -ForegroundColor White
Write-Host ""
Write-Host "4. Test et:" -ForegroundColor White
Write-Host "   aws sts get-caller-identity" -ForegroundColor Gray
Write-Host ""

# Credentials dosyasını aç
$response = Read-Host "Credentials dosyasını şimdi açmak ister misiniz? (E/H)"
if ($response -eq "E" -or $response -eq "e") {
    notepad $credentialsFile
}
