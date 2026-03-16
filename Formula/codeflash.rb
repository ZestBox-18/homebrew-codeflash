class Codeflash < Formula
  desc "Local network clipboard sync tool for HarmonyOS, iOS, and macOS"
  homepage "https://github.com/ZestBox-18/homebrew-codeflash"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ZestBox-18/homebrew-codeflash/releases/download/v1.0.0/codeflash-server-macos-arm64.tar.gz"
      sha256 "4a39c55aea0041814231c2fa9ed69ee38015020188b40dda0d8b7ec66130a78e"

      def install
        bin.install "codeflash-server-arm64" => "codeflash-server"
      end
    else
      url "https://github.com/ZestBox-18/homebrew-codeflash/releases/download/v1.0.0/codeflash-server-macos-amd64.tar.gz"
      sha256 "0b80b78fc267830924a6fb6678f771d12c324f5073c555a53e65d758f5b41830"

      def install
        bin.install "codeflash-server-amd64" => "codeflash-server"
      end
    end
  end

  service do
    run [opt_bin/"codeflash-server"]
    keep_alive true
    log_path var/"log/codeflash.log"
    error_log_path var/"log/codeflash.err"
    run_type :immediate
  end

  test do
    assert_predicate bin/"codeflash-server", :exist?
  end
end
