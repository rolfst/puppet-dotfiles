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
  }->
  file{"/${creates}/_vim":
    owner => "${title}",
    ensure => 'link',
    target => "${real_homedir}/.vim"
 }->
  file{"${creates}/_vimrc":
    owner => "${title}",
    ensure => 'link',
    target => "${real_homedir}/.vimrc"
 }->
  file{"${creates}/_tmux.conf":
    owner => "${title}",
    ensure => 'link',
    target => "${real_homedir}/.tmux.conf"
 }
}
