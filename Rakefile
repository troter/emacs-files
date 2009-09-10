# -*- coding:utf-8; mode:ruby -*-
# Rakefile for my emacs configration.
begin; require 'rubygem'; rescue LoadError; end

require 'rake'
require 'rake/clean'
require 'find'

require 'pp'

task :default => [:update]

desc "Update files."
task :update => [:plugins]

EMACS_CONFIGS = FileList["conf/*.el"]
ELISP_INSTALL_DIR = "plugins"
EMACS = "emacs-nox"
EMACS_BATCH = "#{EMACS} --batch -no-init-file -no-site-file"

def auto_install(datasource, package)
  sh <<EOS
#{EMACS_BATCH} --directory #{ELISP_INSTALL_DIR} \
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
  EMACS_CONFIGS.map do |config|
    IO.readlines(config).grep(/\(auto-install-([a-z\-]+?) \"([^"]*?)\"/) do
    pp  [$1, $2]
      auto_install(datasource = $1, package = $2)
    end
  end
end

#["http://svn.coderepos.org/share/config/yasnippet/common"].each do |repos|
#  dest = "#{ELISP_DIR}/yasnippet/snippets"
#  generate_rule_elisp_download(dest, :download_yasnippet) do |t|
#    sh "svn export -q --force #{repos} #{dest}"
#  end
#end

#["http://yasnippet.googlecode.com/files/yasnippet-bundle-0.6.1b.el.tgz"].each do |elisp|
#  dest = "#{ELISP_DIR}/yasnippet-bundle.el"
#  tmp = "#{TMP_DIR}/#{File.basename(elisp)}"
#  generate_rule_elisp_download(dest, :download_yasnippet) do
#    sh "wget #{elisp} --directory-prefix=#{TMP_DIR}"
#    sh "tar xzf #{tmp}"
#    cp dest.pathmap("%f"), dest; rm dest.pathmap("%f")
#  end
#  CLOBBER.include tmp
#end

# clean.
CLEAN.include [
  '*~',
  '*.elc'
]

# End of Rakefile.
