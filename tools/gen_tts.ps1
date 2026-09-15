Add-Type -AssemblyName System.Speech
$s = New-Object System.Speech.Synthesis.SpeechSynthesizer
$s.SetOutputToWaveFile('E:\AI-Station\tests\fixtures\tts_zh.wav')
$s.Speak('你好，请帮我调研一下腾讯办公助手的定价策略，明天上午要结果')
$s.Dispose()
Write-Output DONE
