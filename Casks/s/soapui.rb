cask "soapui" do
  version "5.7.2"
  sha256 "25cf37f861c2bc95fea272d8ccbaff04fdcb8e14dfa1cc1b1d649918ef51a4d4"

  url "https://dl.eviware.com/soapuios/#{version}/SoapUI-#{version}.dmg",
      verified: "dl.eviware.com/soapuios/"
  name "SmartBear SoapUI"
  desc "API testing tool"
  homepage "https://www.soapui.org/"

  livecheck do
    url "https://www.soapui.org/downloads/latest-release/"
    regex(%r{href=.*?/SoapUI[._-]v?(\d+(?:\.\d+)+)\.dmg}i)
  end

  installer script: {
    executable: "SoapUI #{version} Installer.app/Contents/MacOS/JavaApplicationStub",
    # For future Cask maintainers, if any of these variables
    # change in future versions from SmartBear, you can run
    # the installer manually and then check the values in
    # the following file generated by the installation:
    #  /Applications/SoapUI-${version}.app/Contents/java/app/.install4j/response.varfile
    args:       [
      "-q", # Unattended mode
      "-VcreateDesktopLinkAction$Boolean=false", # Do not create a desktop icon
      "-Vsys.component.132$Boolean=true", # Install SoapUI
      "-Vsys.component.714$Boolean=false", # Do not install source
      "-Vsys.component.1263$Boolean=false", # Do not install HermesJMS
      "-Vsys.component.2393$Boolean=false", # Do not install tutorials
      "-VshowFileAction$Boolean=false", # Do not show release notes
      "-Vsys.installationDir=#{appdir}", # Install to #{appdir} (default: /Applications)
      "-VexecutionLauncherAction$Boolean=false", # Do not launch SoapUI after installing
    ],
  }

  uninstall trash: "#{appdir}/SoapUI-#{version}.app"

  zap trash: [
    "~/.soapuios",
    "~/default-soapui-workspace.xml",
    "~/soapui-settings.xml",
    "~/Library/Application Support/SoapUI-*",
  ]
end
