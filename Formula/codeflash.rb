class Codeflash < Formula
  desc "Local network clipboard sync tool for HarmonyOS, iOS, and macOS"
  homepage "https://github.com/ZestBox-18/homebrew-codeflash"
  version "1.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ZestBox-18/homebrew-codeflash/releases/download/v1.0.1/codeflash-server-macos-arm64.tar.gz"
      sha256 "1ba64b7dcfaccaab1a37fd393fbb922959c7c17f2387036fbf6c30b1ee945049"

      def install
        bin.install "codeflash-server-arm64" => "codeflash-server"
      end
    else
      url "https://github.com/ZestBox-18/homebrew-codeflash/releases/download/v1.0.1/codeflash-server-macos-amd64.tar.gz"
      sha256 "58d189c0f2946a985efdd4e1f07d97d0870d8a8496b7462a4d38e9fa11b98e0b"

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

  def post_install
    return unless $stdout.tty?
    return if ENV["TERM"] == "dumb" || ENV.key?("NO_COLOR")

    color_reset = "\e[0m"
    color_a = "\e[38;5;45m"
    color_b = "\e[38;5;213m"

    puts color_a
    puts "   _____          _      ______ _           _     "
    puts "  / ____|        | |    |  ____| |         | |    "
    puts " | |     ___   __| | ___| |__  | | __ _ ___| |__  "
    puts color_b
    puts " | |    / _ \\ / _` |/ _ \\  __| | |/ _` / __| '_ \\ "
    puts " | |___| (_) | (_| |  __/ |    | | (_| \\__ \\ | | |"
    puts "  \\_____\\___/ \\__,_|\\___|_|    |_|\\__,_|___/_| |_|"
    puts color_reset
  end

  def caveats
    <<~EOS
      CodeFlash

        _____          _      ______ _           _
       / ____|        | |    |  ____| |         | |
      | |     ___   __| | ___| |__  | | __ _ ___| |__
      | |    / _ \ / _` |/ _ \  __| | |/ _` / __| '_ \
      | |___| (_) | (_| |  __/ |    | | (_| \__ \ | | |
       \_____\___/ \__,_|\___|_|    |_|\__,_|___/_| |_|

      启动后台服务：
        brew services start codeflash

      查看日志：
        tail -n 200 "#{var}/log/codeflash.log"

      停止服务：
        brew services stop codeflash
    EOS
  end

  test do
    assert_predicate bin/"codeflash-server", :exist?
  end
end
