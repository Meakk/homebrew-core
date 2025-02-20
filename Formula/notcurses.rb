class Notcurses < Formula
  desc "Blingful character graphics/TUI library"
  homepage "https://nick-black.com/dankwiki/index.php/Notcurses"
  url "https://github.com/dankamongmen/notcurses/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "b4839108ca8f9aef31d2f537485cbd878356bbcd4ad4f7a4dd19e72201d01cee"
  license "Apache-2.0"

  bottle do
    sha256 arm64_monterey: "3f3e0ae16d53e70cf75f524cafa33ab4d3788a3506034c60f0e7d95bbc9df270"
    sha256 arm64_big_sur:  "f0288ba7187d310ebd1351d1ea2cf6544db314ce56bed73b6051c0da1911a423"
    sha256 monterey:       "cc70b219fb6d8d484f2ef75c22ebd9b246491c2b1bae7759192eb10b718b0f2e"
    sha256 big_sur:        "f3d7743f9536342395d835f3a053d003d5005c62ed53b1a027357ad865cbd963"
    sha256 catalina:       "54c05406d94551aa9f702e7346b148dcf37aa7d376c6b7ba35bbc94c4aa1e4cf"
  end

  depends_on "cmake" => :build
  depends_on "doctest" => :build
  depends_on "pandoc" => :build
  depends_on "pkg-config" => :build
  depends_on "ffmpeg"
  depends_on "libdeflate"
  depends_on "libunistring"
  depends_on "ncurses"

  fails_with gcc: "5"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # current homebrew CI runs with TERM=dumb. given that Notcurses explicitly
    # does not support dumb terminals (i.e. those lacking the "cup" terminfo
    # capability), we expect a failure here. all output will go to stderr.
    assert_empty shell_output("#{bin}/notcurses-info", 1)
  end
end
