# -*- mode: ruby; coding: utf-8-unix; indent-tabs-mode: nil -*-
# Rakefile for my emacs configration.

begin; require 'rubygem'; rescue LoadError; end
require 'rake'
require 'rake/clean'

CLEAN.include('**/*~', '**/*.elc')
CLOBBER.include('anything-c-adaptive-history')
CLOBBER.include('auto-save-list')

# commands
EMACS    = ENV['EMACS_CMD'] || "emacs"
RUBY_1_9 = ENV["RUBY_1_9_CMD"] || "ruby"

def elisp(src, options=[], &block)
  sh %Q!#{EMACS} --batch --no-site-file #{options.join(' ')} --eval "#{src}"!, &block
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

namespace :elisp do
  desc "Update elisp using auto-install."
  task :update do
    #FileList["**/.gitmodules"].each do |gitmodule|
    #  cd File.dirname(gitmodule) do
    #    sh "git submodule update --init"
    #  end
    #end

    puts <<-EOS
      (setq auto-install-save-confirm nil
            auto-install-package-name-list nil
            auto-install-install-confirm nil)
    EOS
    FileList["conf/*.el"].each do |config|
      IO.readlines(config).grep(/\(auto-install-([a-z\-]+?) \"([^"]*?)\"/) do
        puts  "(auto-install-#{$1} \"#{$2}\")"
        #auto_install(datasource = $1, package = $2, install_dir = 'plugins')
      end
    end
  end

  desc "Compile elisp."
  task :compile do
    load_path = ['plugins'] + Dir.glob('plugins/*/')
    options = load_path.map {|p| "--directory #{p}" }
    FileList['plugins/**/*.el'].each do |el|
      elisp %Q!(byte-compile-file \\"#{el}\\")!, options do |ok, status|
        puts "Compile failed: #{status}" unless ok
      end
    end
  end

  desc "Install info."
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
end

namespace :ruby do
  desc "Setup rurima and make index"
  task :rurema do
    mkdir_p "misc"; cd "misc" do
      sh "svn co http://jp.rubyist.net/svn/rurema/doctree/trunk rubydoc" unless File.exists? "rubydoc"
      cd "rubydoc" do
        sh "svn update"
        safe_unlink "ar-index.rb"
        sh "wget http://www.rubyist.net/~rubikitch/archive/ar-index.rb"
        sh "#{RUBY_1_9} ar-index.rb . rurema.e"
      end
    end
  end
end

# End of Rakefile.
