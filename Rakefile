# -*- mode: ruby; coding: utf-8-unix; indent-tabs-mode: nil -*-
# Rakefile for my emacs configration.
begin; require 'rubygem'; rescue LoadError; end

require 'rake'
require 'rake/clean'
require 'find'

task :default => [:update]

desc "Update files."
task :update => [:plugins]

EMACS = "emacs-nox"
EMACS_BATCH = "#{EMACS} --batch -no-init-file -no-site-file"
def auto_install(datasource, package, install_dir)
  sh <<-EOS
    #{EMACS_BATCH} --directory #{install_dir} \
    --eval "
    (progn
      (require 'auto-install)
      (require 'cl)
      (setq auto-install-directory (concat (car load-path) \\"/\\")
            auto-install-save-confirm nil
            auto-install-package-name-list nil
            auto-install-install-confirm nil)
      (auto-install-#{datasource} \\"#{package}\\")
      (while (reduce '(lambda (x y) (or x y))
    		 (mapcar '(lambda (b) (assoc 'auto-install-download-buffer
                                                 (buffer-local-variables b)))
                             (buffer-list)))
        (sit-for 1)))
    "
  EOS
end

task :plugins do
  install_dir = 'plugins'
  FileList["conf/*.el"].map do |config|
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


#  sh "svn export -q --force #{repos} #{dest}"
#  ["http://svn.coderepos.org/share/config/yasnippet/common"].each do |repos|
#  generate_rule_elisp_download(dest, :download_yasnippet) do |t|
#      
#  end
#end

# clean.
CLEAN.include [
  '*~',
  '*.elc'
]

# End of Rakefile.
