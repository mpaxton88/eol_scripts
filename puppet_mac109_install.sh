# This script automates the puppet install process
# Last updated by mpp - 5/12/2014

# create needed directories
mkdir /mnt
mkdir /etc/local
mkdir /etc/puppet
mkdir /etc/puppet/conf-orig

# mount /net/adm to get puppet configs
mount -t nfs j1.eol.ucar.edu:/vol/adm /mnt

# install puppet and terminal-notifier
gem install puppet
gem install terminal-notifier

# save original puppet confs
cp /etc/puppet/*.conf /etc/puppet/conf-orig

# copy eol puppet conf to puppet dir
cp /mnt/master/puppet/* /etc/puppet

# run puppet
puppet agent --test --server puppetmaster.eol.ucar.edu --waitforcert 15

# run launchctl
launchctl load -w /Library/LaunchDaemons/com.puppetlabs.puppet.plist

