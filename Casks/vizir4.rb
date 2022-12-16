cask "vizir4" do
  version "2022.10.18"
  sha256 :no_check

  url "https://pyamg.saclay.inria.fr/download/vizir/exes/Mac/vizir4.#{version}.dmg"
  name "ViZiR 4"
  desc "Interactive meshes and solutions visualization tool"
  homepage "https://pyamg.saclay.inria.fr/vizir4.html"

  livecheck do
    url "https://pyamg.saclay.inria.fr/download/vizir/exes/Mac"
    strategy :page_match
    regex(/href=.*?vizir4.?(\d+(?:\.\d+)+).dmg/i)
  end

  app "vizir4.app"

  caveats do
    path_environment_variable "#{appdir}/vizir4.app/Contents/MacOS"
  end
end
