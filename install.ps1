if ($Host.Version.Major -lt 3) {
    throw "Powershell v3 or greater is required."
}

push-location $psscriptroot
try {
    # download and extract ConEmu
    if (!(test-path .\conemu)) {
        write-host "Installing ConEmu..." -foregroundcolor cyan
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        invoke-webrequest 'https://github.com/Maximus5/ConEmu/releases/download/v18.06.26/ConEmuPack.180626.7z' -usebasicparsing -usedefaultcredentials -outfile .\ConEmu.7z
        .\7za.exe x conemu.7z
        del conemu.7z
        write-host "done." -foregroundcolor green
    }

    # download default ConEmu configuration
    if (!(test-path .\ConEmu.xml)) {
        (new-object net.webclient).downloadstring('https://gist.githubusercontent.com/xpando/e6323178eb20a023a939/raw/927b3bb9db8e8a68b5e3c57a778fb8913770c155/ConEmu.xml') | out-file ConEmu.xml
    }
}
finally {
    pop-location
}
