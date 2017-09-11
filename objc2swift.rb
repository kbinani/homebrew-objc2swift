class Objc2swift < Formula
  desc "Open Source Obj-C to Swift Converter."
  homepage "http://objc2swift.yahoo-labs.jp/"
  head "https://github.com/yahoojapan/objc2swift.git"

  depends_on :java

  def install
    open("build.gradle", "a") do |f|
      f << <<-EOS.undent
        task printVersion << {
            println version
        }
      EOS
    end

    v = `./gradlew printVersion --quiet`.chomp
    system "./gradlew jar"


    libexec.install "build/libs/objc2swift-#{v}.jar"
    (bin/"objc2swift").write <<-EOS.undent
      #!/bin/sh
      java -jar #{libexec}/objc2swift-#{v}.jar "$@"
    EOS
  end
end
