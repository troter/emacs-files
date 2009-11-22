# -*- mode: ruby; coding: utf-8-unix; indent-tabs-mode: nil -*-
# Rakefile for my emacs configration.
#
# TODO:
# - ruleを使った形に変更する
# - yasnippet-bundleからbundleでない形にする
#
begin; require 'rubygem'; rescue LoadError; end

require 'rake'
require 'rake/clean'
require 'find'

task :default => [:update]

desc "Update files."
task :update => [:plugins, :compile, :info]

def elisp(src, option="", &block)
  emacs = ENV['EMACS_CMD'] || "emacs"
  sh %Q!#{emacs} --batch --no-site-file #{option} --eval "#{src}"!, &block
end

def auto_install(datasource, package, install_dir)
  elisp (<<EOS
(progn
  (setq install_dir (expand-file-name "#{install_dir}")
        load-path (cons install_dir load-path)
        auto-install-directory install_dir
        auto-install-save-confirm nil
        auto-install-package-name-list nil
        auto-install-install-confirm nil)
  (require 'auto-install)
  (require 'cl)
  (get-buffer-create "*Messages*")

  (defadvice auto-install-install (around replace-message-auto-install-install activate)
    (defalias 'old-message (symbol-function 'message))
    (letf* (((symbol-function 'message)
             (lambda (format-string &rest args)
 ;              (apply 'old-message (cons format-string args))
               (with-current-buffer (get-buffer "*Messages*")
                 (insert (format "%s" format-string))))))
      ad-do-it))
  (ad-activate 'auto-install-install)

  (auto-install-#{datasource} "#{package}")

  (with-current-buffer (get-buffer "*Messages*")
    (while (not (search-forward "Installation is completed." nil t))
      (goto-char (point-min))
      (sit-for 1))))
EOS
).gsub("\"", "\\\"")
end

task :plugins do
  install_dir = 'plugins'
  FileList["conf/*.el"].each do |config|
    IO.readlines(config).grep(/\(auto-install-([a-z\-]+?) \"([^"]*?)\"/) do
      auto_install(datasource = $1, package = $2, install_dir)
    end
  end
end

EL_FILES = FileList['plugins/**/*.el']
ELC_FILES = EL_FILES.ext('.elc')
task :compile => ELC_FILES

rule '.elc' => ".el" do |t|
  elisp %Q!(byte-compile-file \\"#{t.source}\\")!, %Q!--directory plugins! do |ok, status|
    puts "Compile failed: #{status}" unless ok
  end
end

task :info do
  sh <<-EOS
    install-info --name=php-mode --description="Major mode for editing PHP code." \
    --info-file=info/php-mode.info.gz --info-dir=info
  EOS
  sh <<-EOS
    install-info --info-file=info/elisp-ja.info --info-dir=info;\
    install-info --info-file=info/emacs-lisp-intro-ja.info --info-dir=info
  EOS
end

# clean.
CLEAN.include [
  '**/*~',
  '**/*.elc'
]

# End of Rakefile.
