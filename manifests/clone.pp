define dotfiles::clone(
    $gituser,
    $giturl  = "git://github.com",
    $project = "dotfiles",
    $branch  = "master",
    $homedir,
    $creates,
  ) {
  exec { "clone ${gituser} dotfiles for ${title}":
    cwd     => "${homedir}",
    command => "git clone ${giturl}/${gituser}/${project}.git --branch $branch",
    creates => "${creates}",
    user    => "${title}",
    path    => '/usr/bin:/usr/sbin:/usr/local/bin',
    require => Package['git'],
  }
}
