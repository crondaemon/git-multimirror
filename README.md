# Git Multimirror utility

This utility works to mirror one central git repository to many secondary repos. It is intended to run frequently (as in a cron job) to make mirrors updates as fast as possible. It supports multiple projects.

## Installing utility dependencies

`git-multimirror` relies on Gemfile. Run `bundler` to install all necessary packages.

## Configuration file

The [YAML](http://yaml.org/) configuration file is to be configured to support your project. An example for wireshark is provided:

```
logfile: multimirror.log

projects:
  - { 
      name: 'wireshark',
      source: 'https://code.wireshark.org/review/wireshark',
      path: '/var/tmp',
      destinations: [
        { name: 'gitlab', url: 'git@gitlab.com:crondaemon/wireshark.git' },
        { name: 'github', url: 'git@github.com:crondaemon/wireshark.git' }
      ]
    }
```

the `projects` array must be populated with your projects (not necessarily related). The `path` value should be a persistent storage (not tmpfs) to avoid cloning every time the tmpfs is cleaned.

The destinations should be already configured to push without password. Otherwise the utility will stuck. If you plan to run it by hand, it will work, but for a cron job, it should not need it.

## Crontab configuration

The utility works from an unpriviledged user that can run cron jobs. Add the following line to your crontab (as in `crontab -e`)

```
* * * * * <path to git-mirror>/git-mirror <path to config file>/mirrors.yml
```

## Contributions

Pull requests are welcome.
