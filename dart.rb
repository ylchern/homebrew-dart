class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.0.0"
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7cb9e65cea94ce23b05af4e5224ec416b26c3fb6bf0718778b68f6a73e617cc3"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "da55f8fce70ca46e97304810406c89f039464be909b9b92f13986ce918da6775"
  end

  devel do
    version "2.1.0-dev.3.1"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.0-dev.3.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "42b89574b6d179241fc54871cb8a32914eae581ea0db26eb8958931db9394d70"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.0-dev.3.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "ba3f6e318589788bf97d344700797499610f3661183c9fa6120feb44673be6a7"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<~EOS
    Please note the path to the Dart SDK:
      #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
