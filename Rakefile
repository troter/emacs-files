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
  elisp <<EOS
(progn
  (setq install_dir (expand-file-name \\"#{install_dir}\\")
        load-path (cons install_dir load-path)
        auto-install-directory install_dir
        auto-install-save-confirm nil
        auto-install-package-name-list nil
        auto-install-install-confirm nil)
  (require 'auto-install)
  (require 'cl)
  (auto-install-#{datasource} \\"#{package}\\")
  (while (reduce '(lambda (x y) (or x y))
		 (mapcar '(lambda (b)
			    (assoc 'auto-install-download-buffer
				   (buffer-local-variables b)))
			 (buffer-list)))
    (sit-for 1)))
EOS
end

task :plugins do
  install_dir = 'plugins'
  FileList["conf/*.el"].each do |config|
    IO.readlines(config).grep(/\(auto-install-([a-z\-]+?) \"([^"]*?)\"/) do
      auto_install(datasource = $1, package = $2, install_dir)
    end
  end

  # yasnippet
  yasnippet_url = "http://yasnippet.googlecode.com/files/yasnippet-bundle-0.6.1b.el.tgz"
  sh <<-EOS
    wget "#{yasnippet_url}"
    tar xzf #{yasnippet_url.pathmap('%f')}
    mv yasnippet-bundle.el #{install_dir}/
    rm  #{yasnippet_url.pathmap('%f')}
  EOS
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
end

# clean.
CLEAN.include [
  '**/*~',
  '**/*.elc'
]

# End of Rakefile.
