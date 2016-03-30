# to scp a file to all lucid hosts of a certain type
for host in $(lucid-prod list name:doc); do scp $file $host:~/ & done; wait

# to make it so scp doesn't ask if you want to connect to servers with a particular host name
# add the following to ~/.ssh/config
Host $host
    StrictHostKeyChecking no
