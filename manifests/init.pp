define dotfiles (
  $gituser,
  $giturl       = "git://github.com",
  $project      = "dotfiles",
  $dotfiles_dir = 'home',
  $branch       = "master",
  $homedir      = '',
  $clobber      = true,
  $bak_ext      = '.bak',
  $single_pull  = false,
  $rebase       = true,
  $frequency    = 30,
) {

  if $homedir == '' {
    $real_homedir = "/home/${title}"
  } else {
    $real_homedir = $homedir
  }

  $creates = "${real_homedir}/${project}"

  dotfiles::clone {$title:
    gituser => $gituser,
    giturl  => $giturl,
    project => $project,
    branch  => $branch,
    homedir => $real_homedir,
    creates => $creates;
  }
  file{"${real_homedir}/.vim":
    owner => "${title}",
    ensure => 'link',
    target => "${creates}/_vim"
 }
  file{"${real_homedir}/.vimrc":
    owner => "${title}",
    ensure => 'link',
    target => "${creates}/_vimrc"
 }
  file{"${real_homedir}/.tmux.conf":
    owner => "${title}",
    ensure => 'link',
    target => "${creates}/_tmux.conf"
 }
 file {"${real_homedir}/bin/start_p":
    owner => "${title}",
    ensure => 'link',
    target => "${creates}/proj_web",
    mode => '0700'
  }
}
