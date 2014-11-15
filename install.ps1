if ($Host.Version.Major -lt 3) {
    throw "Powershell v3 or greater is required."
}

push-location $psscriptroot
try {
    # download and extract ConEmu
    if (!(test-path .\conemu)) {
        write-host "Installing ConEmu..." -foregroundcolor cyan
        invoke-webrequest 'https://conemu.codeplex.com/downloads/get/891710' -usebasicparsing -usedefaultcredentials -outfile .\ConEmu.7z
        .\7za.exe x conemu.7z
        del conemu.7z
        write-host "done." -foregroundcolor green
    }

    # download default ConEmu configuration
    if (!(test-path .\ConEmu.xml)) {
        (new-object net.webclient).downloadstring('https://gist.githubusercontent.com/xpando/e6323178eb20a023a939/raw/808f9a18103c4cd6e1df08375217755872fba05e/ConEmu.xml') | out-file ConEmu.xml
    }
}
finally {
    pop-location
}