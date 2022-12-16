cask "vizir4" do
  version "2022.06.09"
  sha256 :no_check

  url "https://pyamg.saclay.inria.fr/download/vizir/exes/Mac/vizir4.2022.06.09.dmg"
  name "ViZiR 4"
  desc "ViZiR 4 is an interactive meshes and solutions visualization tool developed by the GAMMA team at Inria."
  homepage "https://pyamg.saclay.inria.fr/vizir4.html"

  app "vizir4.app"

  livecheck do
    url "https://pyamg.saclay.inria.fr/download/vizir/exes/Mac"
    strategy :page_match
    regex(/href=.*?vizir4.?(\d+(?:\.\d+)+).dmg/i)
  end

  caveats do
    path_environment_variable "#{appdir}/vizir4.app/Contents/MacOS"
  end
end
