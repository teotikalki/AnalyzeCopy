ZIP_PATH = "/usr/bin/zip"
UNZIP_PATH = "/usr/bin/unzip"

def name
  'zip/unzip'
end

def ignore_tests
  %w(61_fifo 81_hardlink_fifo)
end

def is_installed
  File.exists?(ZIP_PATH) && File.exists?(UNZIP_PATH)
end

def version
  `#{ZIP_PATH} -v`.split("\n")[1].sub(/Info-ZIP.*/m, '').sub(/, by /, '').sub(/This is /, '') + " - " +
  `#{UNZIP_PATH} -v`.split("\n")[0].sub(/Info-ZIP.*/m, '').sub(/, by /, '')
end

def print_full_version
  system "#{ZIP_PATH} -v"
  puts "------------"
  system "#{UNZIP_PATH} -v"
end

def copy_data(source_dir, dest_dir)
  ENV["ZIP_FILE"] = File.join(dest_dir, "testdata")
  ENV["SOURCE_DIR"] = source_dir
  ENV["DEST_DIR"] = dest_dir
  s = <<CMD
mkdir "$DEST_DIR"
cd "$SOURCE_DIR"
sudo #{ZIP_PATH} -r "$ZIP_FILE" .
cd "$DEST_DIR"
sudo #{UNZIP_PATH} -n "$ZIP_FILE"
CMD
  puts s
  puts "------------"
  system s
end
