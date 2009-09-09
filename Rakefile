# -*- coding:utf-8; mode:ruby -*-
# Rakefile for my emacs configration.

begin; require 'rubygem'; rescue LoadError; end

require 'pp'

require 'rake'
require 'rake/clean'
require 'find'

task :default => [:update]

desc "Update files."
task :update => [:plugins]

EMACS_CONFIGS = FileList["conf/*.el"]
ELISP_INSTALL_DIR = "plugins"
EMACS_BATCH = "emacs --batch -no-init-file -no-site-file"

def auto_install(datasource, package)
  sh <<EOS
#{EMACS_BATCH} --directory #{ELISP_INSTALL_DIR} \
--eval "(require 'auto-install)" \
--eval "(setq install-elisp-confirm-flag nil)" \
--eval "(setq auto-install-directory (concat (car load-path) \\"/\\"))" \
--eval "(setq auto-install-save-confirm nil)" \
--eval "(setq auto-install-package-name-list nil)" \
--eval "(setq auto-install-install-confirm nil)" \
--eval "(auto-install-update-emacswiki-package-name nil)" \
--eval "(auto-install-#{datasource} \\"#{package}\\")" \
--eval "(sit-for 4)" \
--eval "(while auto-install-download-buffer-alist (sit-for 1) (print auto-install-download-buffer-alist))" \
--eval "(while auto-install-download-buffer (sit-for 1) (print auto-install-download-buffer))" \
--eval "(sit-for 4)"
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
